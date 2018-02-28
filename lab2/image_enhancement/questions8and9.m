% Load the image
im = im2double(imread('./images/image2.jpg'));

% Question 8: compute and plot image gradients
[Gx, Gy, im_magnitude, im_direction] = compute_gradient(im);

ax1 = subplot(2,2,1); imshow(Gx, []);
title(ax1,'\fontsize{16}Gradient of the image in the x-direction')

ax2 = subplot(2,2,2); imshow(Gy, []);
title(ax2,'\fontsize{16}Gradient of the image in the y-direction')

ax3 = subplot(2,2,3); imshow(im_magnitude, []);
title(ax3,'\fontsize{16}Gradient magnitude')

ax4 = subplot(2,2,4); imshow(im_direction, []);
title(ax4,'\fontsize{16}Gradient direction')

% Question 9: Plotting the results of 3 different methods for computing LoG
figure;
ax1 = subplot(1,3,1);
imshow(compute_LoG(im, 1), []);
title(ax1,'\fontsize{16}Method 1')

ax2 = subplot(1,3,2);
imshow(compute_LoG(im, 2), []);
title(ax2,'\fontsize{16}Method 2')

ax3 = subplot(1,3,3);
imshow(compute_LoG(im, 3), []);
title(ax3,'\fontsize{16}Method 3')

% Question 9.5: gradient magnitude comparison of first order and second 
% order methods
[~,idx_first] = sort(im_magnitude(:), 'descend');
disp(im_magnitude(idx_first(1:10)));

LoG = compute_LoG(im, 2);
[~,idx_second] = sort(LoG(:), 'descend');
disp(LoG(idx_second(1:10)));