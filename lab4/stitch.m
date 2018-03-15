clear all; close all; clc;


im1_original = imread('left.jpg');
im2_original = imread('right.jpg');

channels = 1;
if ndims(im1_original) == 3
    [~, ~, channels] = size(im1_original);
    im1 = rgb2gray(im1_original);
end

if ndims(im2_original) == 3
    im2 = rgb2gray(im2_original);
end

% convert to type single
im1_s = single(im1);
im2_s = single(im2);

[matchings, f1, d1, f2, d2] = keypoint_matching(im1_s, im2_s);
T = RANSAC(matchings, f1, f2, 10000, 5);
im2_tr = transform_image(im2_original, T, 'none');

[h1, w1] = size(im1);
[h2, w2] = size(im2);
[h2_tr, w2_tr, ~] = size(im2_tr);

h_stitched = max(h1, h2_tr);
w_stitched = round(w2_tr - T(5) + 1);
im_stitched = zeros(h_stitched, w_stitched, channels);

% TODO expand im1 just in case
im_stitched(:, 1:w1, :) = im1_original;

h_shift = round(- T(6) +  h2 - h_stitched + 1 );
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

% subplot(1,4,1), imshow(im1_original)
% subplot(1,4,2), imshow(im2_original)
% subplot(1,4,3), imshow(uint8(im2_tr))
% subplot(1,4,4), 
imshow(uint8(im_stitched))