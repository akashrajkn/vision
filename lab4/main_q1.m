clear all;
clc;

% -------------------------- Params --------------------------
samples = 50;  % number of matchings to take
N = 50;        % number of times to run RANSAC
P = 10;        % subset of matchings
% ------------------------------------------------------------

% -------------------------- Images --------------------------
image1 = imread('boat1.pgm');
image2 = imread('boat2.pgm');

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
matchings = matchings(:, sel);

% -------------------------- Plots ---------------------------
plot_descriptors(image1, image2, matchings, f1, f2)
% ------------------------------------------------------------

% Question 3: Find best transformation with RANSAC
best_transformation = RANSAC(matchings, f1, f2, N, P);
image2_transformed = transform_image(image2, best_transformation);

% -------------------------- Plots ---------------------------
figure; 
subplot(1,2,1); imshow(image1)
subplot(1,2,2); imshow(uint8(image2_transformed))
% ------------------------------------------------------------
