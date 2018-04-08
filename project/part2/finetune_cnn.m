function [net, info, expdir] = finetune_cnn(batchSize, numEpochs)

%% Define options
%run(fullfile(fileparts(mfilename('fullpath')), ...
%  '..', '..', '..', 'matlab', 'vl_setupnn.m')) ;

opts.modelType = 'lenet' ;
%[opts, varargin] = vl_argparse(opts, varargin) ;

opts.expDir = fullfile('data', ...
  sprintf('cnn_assignment-%s', opts.modelType)) ;
%[opts, varargin] = vl_argparse(opts, varargin) ;

opts.dataDir = './data/' ;
opts.imdbPath = fullfile(opts.expDir, 'imdb-caltech.mat');
opts.whitenData = true ;
opts.contrastNormalization = true ;
opts.networkType = 'simplenn' ;
opts.train = struct() ;
%opts = vl_argparse(opts, varargin) ;
if ~isfield(opts.train, 'gpus'), opts.train.gpus = []; end;

%opts.train.gpus = [1];



%% update model

net = update_model(batchSize, numEpochs);

%% load data
if exist(opts.imdbPath, 'file')
  imdb = load(opts.imdbPath) ;
else
  imdb = getCaltechIMDB() ;
  mkdir(opts.expDir) ;
  save(opts.imdbPath, '-struct', 'imdb') ;
end

%%
net.meta.classes.name = imdb.meta.classes(:)' ;

% -------------------------------------------------------------------------
%                                                                     Train
% -------------------------------------------------------------------------

trainfn = @cnn_train ;
[net, info] = trainfn(net, imdb, getBatch(opts), ...
  'expDir', opts.expDir, ...
  net.meta.trainOpts, ...
  opts.train, ...
  'val', find(imdb.images.set == 2)) ;

expdir = opts.expDir;
end
% -------------------------------------------------------------------------
function fn = getBatch(opts)
% -------------------------------------------------------------------------
switch lower(opts.networkType)
  case 'simplenn'
    fn = @(x,y) getSimpleNNBatch(x,y) ;
  case 'dagnn'
    bopts = struct('numGpus', numel(opts.train.gpus)) ;
    fn = @(x,y) getDagNNBatch(bopts,x,y) ;
end

end

function [images, labels] = getSimpleNNBatch(imdb, batch)
% -------------------------------------------------------------------------
images = imdb.images.data(:,:,:,batch) ;
labels = imdb.images.labels(1,batch) ;
if rand > 0.5, images=fliplr(images) ; end

end

% -------------------------------------------------------------------------
function imdb = getCaltechIMDB()
% -------------------------------------------------------------------------
% Preapre the imdb structure, returns image data with mean image subtracted
classes = {'airplanes', 'cars', 'faces', 'motorbikes'};
splits = {'train', 'test'};
imdata_dir = '../Caltech4/ImageData/';

sets = [];
labels = [];
fnames = [];
class_id = 1;
for class = classes
    for split = splits      
        combo_path = string(strcat(imdata_dir, class, '_' ,split));
        dinfo = dir(combo_path);
        
        fnames_combo = strcat(combo_path, '/', {dinfo.name});
        % remove '.', '..' from every fnames_combo
        fnames_combo = fnames_combo(3:end);
        fnames = [fnames, fnames_combo];
        
        labels_combo = ones(size(fnames_combo,2), 1) * class_id;
        labels = cat(1, labels, labels_combo);
        
        % 1 for training, adds 1 (for the total of 2) if split == 'test'
        sets_combo = ones(size(fnames_combo,2), 1) + strcmp(split,'test');
        sets = cat(1, sets, sets_combo);
    end
    class_id = class_id + 1;
end

data = zeros(32, 32, 3, size(fnames, 1));
fnames = cellstr(reshape(fnames, [size(fnames, 2),1]));
im_data = vl_imreadjpeg(fnames, 'Resize', [32, 32]);
% This could have been done in the for loop above, but would have slowed
% things down due to reallocating significant chunks of memory multiple
% times (whereas the first for loop does this with very small arrays)
for i=1:size(fnames, 1)
    im = im_data{i};
    % if the image is grayscale, repeat it on all channels
    if size(im, 3) == 1
        im = repmat(im,1,1,3);
    end
    data(:,:,:, i) = im;
end
data(isnan(data)) = 0;
data = single(data/255);
labels = single(labels');
sets = single(sets);

%%
% subtract mean
dataMean = mean(data(:, :, :, sets == 1), 4);
data = bsxfun(@minus, data, dataMean);

imdb.images.data = data ;
imdb.images.labels = single(labels) ;
imdb.images.set = sets;
imdb.meta.sets = {'train', 'val'} ;
imdb.meta.classes = classes;

perm = randperm(numel(imdb.images.set));
imdb.images.data = imdb.images.data(:,:,:, perm);
imdb.images.labels = imdb.images.labels(perm);
imdb.images.set = imdb.images.set(perm);

end
