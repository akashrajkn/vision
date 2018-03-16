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
    
    % compute the parameters of the transformation needed to align ima1 and
    % im2 using the matched keypoints
    [matchings, f1, d1, f2, d2] = keypoint_matching(im1_s, im2_s);
    T = RANSAC(matchings, f1, f2, 10000, 5);
    % transfrom im2 such that the objects are in the same "pose" as in im1
    im2_tr = transform_image(im2_original, T);

    [h1, w1] = size(im1);
    [h2, w2] = size(im2);
    [h2_tr, w2_tr, ~] = size(im2_tr);
    
    % TODO expand im1 just in case
    % compute the size of the stitched image 
    h_stitched = max(h1, h2_tr);
    w_stitched = round(w2_tr - T(5) + 1);
    
    % allocate an array of zeros for the stitched image 
    im_stitched = zeros(h_stitched, w_stitched, channels);

    % fill in the part of the stitched image from the first image
    im_stitched(1:h1, 1:w1, :) = im1_original;
    
    h_shift = round(- T(6) +  h2 - h_stitched + 1);
    w_shift = round(- T(5) + 1);

    % stitching with original im1 on top
    im_stitched(h_shift:h_shift+h2_tr-1, w1:w_shift+w2_tr-1, :) = im2_tr(:, w1-w_shift+1:end, :);

    % stitching with transformed im2 on top
    % for i = 1:h2_tr
    %     for j = 1:w2_tr
    %         if im2_tr(i, j) > 0
    %             im_stitched(i + h_shift, j + w_shift) = im2_tr(i, j);
    %         end
    %     end
    % end
end