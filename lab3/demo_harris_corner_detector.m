im_name = 'pingpong';
sigma = 1;
n = 2;
thres = .1;

switch im_name
    case 'pingpong'
        im_original = imread('./pingpong/0000.jpeg');
    case 'toy'
        im_original = imread('./person_toy/00000001.jpg')
end

% Detect corners in the image; generate plots of the gradients and corners
[H, row, col] = harris_corner_detector(im_original, sigma, n, thres, true);

figure();
for i=1:5
    % Randomly rotate the image
    im = imrotate(im_original, randi([0, 360]));
    % Detect the corners in the rotated image and add the subplot
    [H, row, col] = harris_corner_detector(im, sigma, n, thres, false);
    subplot(1,5,i); imshow(im); hold on;
    plot(col, row, 'o', 'MarkerEdgeColor','blue', 'MarkerSize', 8);
end
