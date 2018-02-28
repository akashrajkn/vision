im = im2double(imread('./images/image2.jpg'));

% Question 8: compute and plot image gradients
[Gx, Gy, im_magnitude, im_direction] = compute_gradient(im);

imshowpair(Gx, Gy, 'montage');
title('\fontsize{16}Gradient of the image in the x-direction (left) and the y-direction (right).');

figure; imshowpair(im_magnitude, im_direction, 'montage');
title('\fontsize{16}Gradient magnitude (left) and gradient direction (right).');

% Question 9: Plotting the results of 3 different methods for computing LoG

figure;
ax1 = subplot(1,3,1);
imshow(compute_LoG(im, 1));
title(ax1,'\fontsize{16}Method 1')

ax2 = subplot(1,3,2);
imshow(compute_LoG(im, 2));
title(ax2,'\fontsize{16}Method 2')

ax3 = subplot(1,3,3);
imshow(compute_LoG(im, 3));
title(ax3,'\fontsize{16}Method 3')