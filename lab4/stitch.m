clear all; close all; clc;


image1 = imread('left.jpg');
image2 = imread('right.jpg');

if ndims(image1) == 3
    image1 = rgb2gray(image1);
end

if ndims(image2) == 3
    image2 = rgb2gray(image2);
end

% convert to type single
image1_s = single(image1);
image2_s = single(image2);

[matchings, f1, d1, f2, d2] = keypoint_matching(image1_s, image2_s);
T = RANSAC(matchings, f1, f2, 10000, 10);
%T = T.*[1, 1, 1, 1, 0, 0]'
%T = T.*[1, -1, -1, 1, -1, -1]';

[h1, w1] = size(image1);
[h2, w2] = size(image2);

%disp([top_left_corner, bottom_left_corner, top_right_corner, bottom_right_corner])


transformed_image = transform_image(image2, T, 'none');


subplot(1,3,1), imshow(image1)
subplot(1,3,2), imshow(image2)
subplot(1,3,3), imshow(uint8(transformed_image))