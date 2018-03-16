% Demo file for Image Alignment task.

clear all;
clc;

% -------------------------- Params --------------------------
samples = 50;  % number of matchings to take
N = 50;        % number of iterations in RANSAC
P = 3;         % subset of matchings to consider in RANSAC
% ------------------------------------------------------------

% Align boat2 to pose objects in boat1
image_alignment('boat1.pgm', 'boat2.pgm', samples, N, P, true)
% Align boat1 to pose objects in boat2
image_alignment('boat2.pgm', 'boat1.pgm', samples, N, P, false)
