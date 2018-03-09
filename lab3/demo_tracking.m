% Feature tracking

% clear all
% close all
% clc

% input files.
files = dir(fullfile('person_toy', '*.jpg'));

% Hyper parameters
window_size = 15;
sigma = 1;
n = 2;
thres = .1;

% Read first image and generate interest points
image1 = imread(strcat(files(1).folder, '/', files(1).name));
[ ~, r, c ] = harris_corner_detector(image1, sigma, n, thres, false);

% upto the last one
for i = 1:length(files) - 1
   % without the pause statements, matlab seems to be crashing on my system :/
   path1 = strcat(files(i).folder, '/', files(i).name);

   image1 = imread(path1);
   [ ~, r, c ] = harris_corner_detector(image1, sigma, n, thres, false);  % testing

   path2 = strcat(files(i + 1).folder, '/', files(i + 1).name);
   % Lucas Kanade
   [vx, vy, fig] = lucas_kanade(path1, path2, window_size, r, c);
   pause(1);

   % Update the interest points based on the flow components
   r(:) = r(:) + vx(:);
   c(:) = c(:) + vy(:);

   % Save images
   if i > 0
       folder = 'results/tracking_images/';
       file_name = sprintf('%d.jpg', i);
       full_path = fullfile(folder, file_name);
       saveas(fig, full_path, 'jpeg');
       pause(1);
   end

   pause(1);

   % close all;
   % [vx, vy] = lucas_kanade('person_toy/00000001.jpg', 'person_toy/00000002.jpg', 15, r, c);
end
