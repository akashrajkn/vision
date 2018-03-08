function [Vx, Vy] = lucas_kanade(path1, path2, window_size)

% Implementation of the Lucas-Kanade algorithm
%   path1 : path of image 1
%   path2 : path of image 2
% Assumptions
%   1. Cropping the edges does not affect the flow (<14px)
%   2. image1 and image2 have the same size

    if nargin == 2
        window_size = 15;
    end

    image1 = imread(path1);
    image2 = imread(path2);
    % If rgb image, convert to grayscale
    if ndims(image1) == 3
       image1 = rgb2gray(image1);
       image2 = rgb2gray(image2);
    end

    image1 = double(image1);
    image2 = double(image2);

    [size_x, size_y] = size(image1);

    % number of regions in x and y directions
    num_x = floor(size_x / window_size);
    num_y = floor(size_y / window_size);

    regions_x = ones(1, num_x) * window_size;
    regions_y = ones(1, num_y) * window_size;

    % cropped images
    image1 = image1(1: num_x * window_size, 1: num_y * window_size);
    image2 = image2(1: num_x * window_size, 1: num_y * window_size);

    % generate regions from image
    regions1 = mat2cell(image1, regions_x, regions_y);
    regions2 = mat2cell(image2, regions_x, regions_y);

    Vx = zeros(size(regions1));
    Vy = zeros(size(regions1));
    filter = [1 1; 1 1];

    for i = 1:num_x
        for j = 1:num_y

            a = cell2mat(regions1(i, j));
            b = cell2mat(regions2(i, j));

            % Compute I_x, I_y, I_y
            [I_x, I_y] = gradient(a);
            I_t = double(conv2(a, filter, 'same')) - double(conv2(b, filter, 'same'));

            A = [I_x(:) I_y(:)];
            v = pinv(A) * I_t(:);

            Vx(i, j) = v(1);
            Vy(i, j) = v(2);
        end
    end

    coordinates_x = [ceil(window_size / 2) : window_size : num_x*window_size];
    coordinates_y = [ceil(window_size / 2) : window_size : num_y*window_size];

    [X, Y] = meshgrid(coordinates_x, coordinates_y);

    figure;
    imshow(imread(path1));
    hold on;
    quiver(X, Y, Vx, Vy, 'w')

end
