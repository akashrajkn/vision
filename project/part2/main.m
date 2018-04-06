%% main function 
%% fine-tune the cnn & get optimal hyperparameters
seeds = 3;
batch_size_array = [50, 100];
num_epochs_array = [40, 80, 120];
results = zeros(length(batch_size_array)*length(num_epochs_array)*seeds, 5);

i = 1;
for num_epochs = num_epochs_array
    for batch_size = batch_size_array
        for seed = 1:seeds
            rng(seed)
            rmdir('data/cnn_assignment-lenet', 's')
            [net, info, expdir] = finetune_cnn(batch_size, num_epochs);
            obj = vertcat(info.val.objective);
            top1err = vertcat(info.val.top1err);
            results(i, :) = [batch_size, num_epochs, top1err(num_epochs), obj(num_epochs), seed];
            i = i+1;
            % save the network and the info if it performs best (so far)
            if top1err(num_epochs) == max(results(:, 3))
                net_fine_tuned_best = net;
                info_fine_tuned_best = info;
                expdir_fine_tuned_best = expdir;
            end
        end
    end
end
disp(results)
dlmwrite('results-hyperparam.txt',results,'delimiter','\t')

% for every hyperparameter setting, take an average of the results obtained
% using different seeds. this works because the seed is alterated in the 
% innermost loop.
res_seeds_avgd_out = arrayfun(@(i) mean(results(i:i+seeds-1, :)), 1:seeds:length(results)-seeds+1, 'un',0)';
res_seeds_avgd_out = cell2mat(res_seeds_avgd_out);
disp(res_seeds_avgd_out)
dlmwrite('results-hyperparam-avg-per-seed.txt',res_seeds_avgd_out,'delimiter','\t')


%% extract features and train svm
nets.fine_tuned = net_fine_tuned_best;
nets.pre_trained = load(fullfile('data', 'pre_trained_model.mat')); nets.pre_trained = nets.pre_trained.net; 
data = load(fullfile(expdir, 'imdb-caltech.mat'));

train_svm(nets, data);

%% T-SNE
% extract features resuing the code from the provided train_svm.m
nets.pre_trained.layers{end}.type = 'softmax';
nets.fine_tuned.layers{end}.type = 'softmax';
[feat.pre_trained.trainset, feat.pre_trained.testset] = get_svm_data(data, nets.pre_trained);
[feat.fine_tuned.trainset, feat.fine_tuned.testset] = get_svm_data(data, nets.fine_tuned);

features_pretrained = full(vertcat(feat.pre_trained.trainset.features, feat.pre_trained.testset.features));
features_finetuned = full(vertcat(feat.fine_tuned.trainset.features, feat.fine_tuned.testset.features));

labels_pretrained = vertcat(feat.pre_trained.trainset.labels, feat.pre_trained.testset.labels);
labels_finetuned = vertcat(feat.fine_tuned.trainset.labels, feat.fine_tuned.testset.labels);

% compute t-sne
tsne_pretrained = tsne(features_pretrained);
tsne_finetuned = tsne(features_finetuned);

% plot t-sne
subplot(1,3,1); 
scatter(tsne_pretrained(:,1), tsne_pretrained(:,2), 10, labels_pretrained, 'filled');
title('\fontsize{14}pre-trained features')

subplot(1,3,2); 
scatter(tsne_finetuned(:,1), tsne_finetuned(:,2), 10, labels_finetuned, 'filled');
title('\fontsize{14}fine-tuned features')

subplot(1,3,3); 
scatter(tsne_finetuned(:,1), tsne_finetuned(:,2), 10, labels_finetuned, 'filled');
title('\fontsize{14}fine-tuned features')
colorbar

%% early stopping
% % retrain the CNN with best hyperparameters for use in further experiments
% rmdir data/cnn_assignment-lenet
% batch_size_best = results(results(:,3) == max(results(:,3)), 1);
% num_epochs_best = results(results(:,3) == max(results(:,3)), 2);
% [net, info, expdir] = finetune_cnn(batch_size, num_epochs);
