% Feature tracking

files = dir(fullfile('pingpong', '*.jpeg'));

% Hyper params
sigma = 1;
n = 2;
thres = .1;

image1 = imread(strcat(files(1).folder, '/', files(1).name));
[ ~, r, c ] = harris_corner_detector(image1, sigma, n, thres, false);

for i = 1:length(files) - 1

    path1 = strcat(files(i).folder, '/', files(i).name);
    path2 = strcat(files(i + 1).folder, '/', files(i + 1).name);

    [vx, vy, fig] = lucas_kanade(path1, path2, 15, r, c);
    pause(2);

    r(:) = r(:) + vx(:);
    c(:) = c(:) + vy(:);

    folder = 'results/tracking_images/';
    file_name = sprintf('%d.jpg', i);
    full_path = fullfile(folder, file_name);
    saveas(fig, full_path, 'jpeg');

    pause(1);

    close all;
    % [vx, vy] = lucas_kanade('person_toy/00000001.jpg', 'person_toy/00000002.jpg', 15, r, c);
end
