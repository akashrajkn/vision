function [Gx, Gy, im_magnitude,im_direction] = compute_gradient(image)
sobel_x = reshape([1, 2, 1, 0, 0, 0, -1, -2, -1], [3, 3]);
sobel_y =  reshape([1, 0, -1, 2, 0, -2, 1, 0, -1], [3 ,3]);

Gx =  imfilter(image, sobel_x, 'conv');
Gy =  imfilter(image, sobel_y, 'conv');

im_magnitude = sqrt(Gx.^2 + Gy.^2);
im_direction = atand(Gy./Gx);
end

