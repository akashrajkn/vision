clear all;
clc;

% -------------------------- Params --------------------------
samples = 50;  % number of matchings to take
N = 50;        % number of times to run RANSAC
P = 3;         % subset of matchings
% ------------------------------------------------------------

% -------------------------- Images --------------------------
image1 = imread('boat2.pgm');
image2 = imread('boat1.pgm');

if ndims(image1) == 3
    image1 = rgb2gray(image1);
end

if ndims(image2) == 3
    image2 = rgb2gray(image2);
end

% convert to type single
image1_s = single(image1);
image2_s = single(image2);
% ------------------------------------------------------------

% Question 1, 2: Keypoint matchings
[matchings, f1, d1, f2, d2] = keypoint_matching(image1_s, image2_s);
perm = randperm(size(matchings, 2));
sel = perm(1:samples);
matchings_sel = matchings(:, sel);

% -------------------------- Plots ---------------------------
plot_descriptors(image1, image2, matchings_sel, f1, f2)
% ------------------------------------------------------------

% Question 3: Find best transformation with RANSAC
[best_transformation, counts] = RANSAC(matchings, f1, f2, N, P);
image2_transformed = transform_image(image2, best_transformation);

% -------------------------- Plots ---------------------------
figure;
ax1 = subplot(1,3,1); imshow(image1)
title(ax1,'\fontsize{16}Original image')
ax2 = subplot(1,3,2); imshow(uint8(image2_transformed))
title(ax2,'\fontsize{16}Our transform')
% ------------------------------------------------------------

pause(0.5);

% Compare with matlab's imtransform
M = [best_transformation(1) best_transformation(2); best_transformation(3) best_transformation(4)];
T = [best_transformation(5) best_transformation(6)];

transformation = maketform('affine', [M ; T]);
transformed_image = imtransform(image2, transformation, 'nearest');

ax3 = subplot(1,3,3); imshow(transformed_image);
title(ax3,'\fontsize{16}MATLAB imtransform and maketform')
