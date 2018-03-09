% Convert image frames to video

workingDir = 'results/tracking_toy/'

imageNames = dir(fullfile(workingDir, '*.jpg'));
% imageNames = {imageNames.name}';

outputVideo = VideoWriter('tracking.avi');
outputVideo.FrameRate = 15;
open(outputVideo)

for ii = 1:length(imageNames)
   file_name = sprintf('%d.jpg', ii);
   img = imread(fullfile(workingDir, file_name));

   % imageNames(ii).name

   % size(img)

   img = img(1:1042, 1:1400, :);
   writeVideo(outputVideo, img)
end

close(outputVideo)
