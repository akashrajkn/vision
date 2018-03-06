


image_original = imread('./pingpong/0000.jpeg');
image_original = imread('./person_toy/00000001.jpg');

[H, row, col] = harris_corner_detector(image_original, 1, 1, .07, true);

figure();
for i=1:5
    im = imrotate(image_original, randi([0, 360]));
    [H, row, col] = harris_corner_detector(im, 1, 1, .07, false);
    subplot(1,5,i)
    imshow(im);
    hold on
    plot(col, row, 'o', 'MarkerEdgeColor','blue', 'MarkerSize', 8);
end