clear all; close all; clc;

% load images
im1 = imread('left.jpg');
im2 = imread('right.jpg');

% stitch the images
im_stitched = stitch(im1, im2);

% plot the resulting stitched image
imshow(uint8(im_stitched))