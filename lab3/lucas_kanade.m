function [Vx, Vy, fig] = lucas_kanade(path1, path2, window_size, interest_x, interest_y)

% Implementation of the Lucas-Kanade algorithm
%   path1 : path of image 1
%   path2 : path of image 2
%   window_size : size of the square window. Default is 15 * 15
%   interest_x : x co-ordinate of interest points
%   interest_y : y co-ordinate of interest points
% Assumptions
%   1. Cropping the edges does not affect the flow (<14px)
%   2. image1 and image2 have the same size

    if nargin == 2
        window_size = 15;
    end

    % Read images
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

    h_w = floor(window_size / 2);

    num_x = size(interest_x, 1);
    num_y = size(interest_y, 1);

    % If interest points are not given, uniformly set them
    if nargin <= 4
        % number of regions in x and y directions
        num_x = floor(size_x / window_size);
        num_y = floor(size_y / window_size);

        interest_x = ones(num_x * num_y , 1);
        interest_y = ones(num_x * num_y , 1);

        count = 1;
        for i = h_w : window_size : size_x

            for j = h_w : window_size : size_y
                interest_x(count) = i;
                interest_y(count) = j;

                count = count + 1;
            end
        end
    end

    Vx = zeros(size(interest_x, 1), 1);
    Vy = zeros(size(interest_y, 1), 1);

    filter = [1 1; 1 1];

    count = 1;
    % for each region
    for i = 1:size(interest_x, 1)

        x = interest_x(i);
        y = interest_y(i);

        % Boundary conditions
        start_x = x - h_w;
        start_y = y - h_w;
        end_x = x + h_w + 1;
        end_y = y + h_w + 1;

        if start_x < 1
            start_x = 1;
        end

        if end_x > size_x
            end_x = size_x;
        end

        if start_y < 1
            start_y = 1;
        end

        if end_y > size_y
            end_y = size_y;
        end

        % regions a, b
        a = image1(start_x:end_x, start_y:end_y);
        b = image2(start_x:end_x, start_y:end_y);

        % Compute I_x, I_y, I_y
        [I_x, I_y] = gradient(a);
        I_t = double(conv2(a, filter, 'same')) - double(conv2(b, filter, 'same'));

        A = [I_x(:) I_y(:)];
        v = pinv(A) * I_t(:);

        Vx(count) = v(1);
        Vy(count) = v(2);

        count = count + 1;
    end

    fig = figure();
    imshow(imread(path1));
    hold on;

    quiver(interest_y, interest_x, Vx, Vy, 'w')

end
