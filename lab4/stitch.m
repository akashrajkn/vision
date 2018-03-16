function [im_stitched] = stitch(im1_original, im2_original)
% Returns an image with im1_original and im2_original stitched
%   @param im1_original - first image to be stitched; assumed to be on the
%   left
%   @param im2_original - second image to be stitched; assumed to be on the
%   right
%
%   @return: im_stitched

    channels = 1;
    if ndims(im1_original) == 3
        [~, ~, channels] = size(im1_original);
        im1 = rgb2gray(im1_original);
    else
        im1 = im1_original;
    end
    
    if ndims(im2_original) == 3
        im2 = rgb2gray(im2_original);
    else
        im2 = im2_original;
    end

    % convert to type single
    im1_s = single(im1);
    im2_s = single(im2);

    % compute the parameters of the transformation needed to align im1 and
    % im2 using the matched keypoints
    [matchings, f1, d1, f2, d2] = keypoint_matching(im1_s, im2_s);
    [T, ~] = RANSAC(matchings, f1, f2, 50, 5);
    % transfrom im2 such that the objects are in the same "pose" as in im1
    [im2_tr, offsets] = transform_image(im2_original, T);

    [h1, w1] = size(im1);
    [h2, w2] = size(im2);
    
    % Get coordinates of the corners of im1 and im2 in the stitched image
    M = reshape(T(1:4), [2,2]);
    cor1 = [1,1; h1,1; 1,w1; h1,w1];
    cor2 = round([1,1; h2,1; 1,w2; h2,w2] * M) - round([T(6), T(5)]);
    cor2(:, 1) = cor2(:, 1) - offsets(1);
    cor2(:, 2) = cor2(:, 2) - offsets(2);
    cor = vertcat(cor1, cor2);
    
    % Ensure there're no negative indices 
    cor(:,1) = cor(:,1) - min(cor(:,1)) + 1;
    cor(:,2) = cor(:,2) - min(cor(:,2)) + 1;
    
    % Create and fill in the stitched image
    im_stitched = zeros(max(cor(:,1)), max(cor(:,2)), channels);    
    im_stitched(min(cor(5:8,1)):max(cor(5:8,1)), min(cor(5:8,2)):max(cor(5:8,2)), :) = im2_tr;
    im_stitched(min(cor(1:4,1)):max(cor(1:4,1)), min(cor(1:4,2)):max(cor(1:4,2)), :) = im1_original;
end
