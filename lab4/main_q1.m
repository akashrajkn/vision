% -------------------------- Params --------------------------
samples = 50;
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
figure(1); clf;
imshow(cat(2, image1, image2));

x1 = f1(1, matchings(1, :));
x2 = f2(1, matchings(2, :)) + size(image1_s, 2);
y1 = f1(2, matchings(1, :));
y2 = f2(2, matchings(2, :));

hold on ;
h = line([x1 ; x2], [y1 ; y2]);
set(h, 'linewidth', 1, 'color', 'b');

vl_plotframe(f1(:, matchings(1, :)));
f2(1,:) = f2(1, :) + size(image1_s, 2);
vl_plotframe(f2(:, matchings(2, :)));
axis image off;
% ------------------------------------------------------------

% Question 3: RANSAC
