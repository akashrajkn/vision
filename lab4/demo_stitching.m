% Demo file for Image Alignment task.

clear all; close all; clc;

% load images
im1 = imread('left.jpg');
im2 = imread('right.jpg');

% stitch the images
im_stitched = stitch(im1, im2);

% plot the original images and the resulting stitched image
subplot(1,2,1); imshow(im1);
subplot(1,2,2); imshow(im2);

figure(); imshow(uint8(im_stitched))
