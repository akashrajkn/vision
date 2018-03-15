clear all
clc

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

% Question 3: Find best transformation
x1 = f1(1, matchings(1, :));
y1 = f1(2, matchings(1, :));
x2 = f2(1, matchings(2, :));
y2 = f2(2, matchings(2, :));

x1_t = x1';
y1_t = y1';

zer = zeros(size(x1_t));
one = ones(size(x1_t));
A_n = [x1_t y1_t zer zer one zer; zer zer x1_t y1_t zer one];
num_p = size(matchings, 2);  % number of points

best_transformation = [];
best_count = 0;

for iteration = 1:N
    % sample P points
    perm = randperm(size(matchings, 2));
    sel = perm(1:P);
    matchings_p = matchings(:, sel);

    T = RANSAC(matchings_p, f1, f2);
    new_points = A_n * T;

    % count inliers;
    count = 0;
    for i = 1:num_p;
        p1_x = new_points(i);
        p1_y = new_points(num_p + i);

        p2_x = x2(i);
        p2_y = y2(i);

        dist = sqrt((p1_x - p2_x) ^ 2 + (p1_y - p2_y) ^ 2);  % Use Euclidean distance

        if dist <= 10
            count = count + 1;
        end
    end

    if count > best_count
        best_count = count;
        best_transformation = T;
    end
end

disp("Best transformation is: ")
disp(best_transformation)

% -------------------------- Plots ---------------------------
plot_ransac(image1, image2, best_transformation)
% ------------------------------------------------------------
