% Load the images
original_im = im2double(imread('./images/image1.jpg'));
noisy_im_saltpepper = im2double(imread('./images/image1_saltpepper.jpg'));
noisy_im_gauss = im2double(imread('./images/image1_gaussian.jpg'));

% Question 6: computing PSNR
fprintf('PSNR between image1_saltpepper.jpg and image1.jpg:\n')
disp(myPSNR(original_im, noisy_im_saltpepper))

fprintf('PSNR between image1_gaussian.jpg and image1.jpg:\n')
disp(myPSNR(original_im, noisy_im_gauss))

% Question 7: denoising
% Denoising image1_saltpepper.jpg 
denoised_saltpepper_box3 = denoise(noisy_im_saltpepper, 'box', 3);
denoised_saltpepper_box5 = denoise(noisy_im_saltpepper, 'box', 5);
denoised_saltpepper_box7 = denoise(noisy_im_saltpepper, 'box', 7);
denoised_saltpepper_med3 = denoise(noisy_im_saltpepper, 'median', 3);
denoised_saltpepper_med5 = denoise(noisy_im_saltpepper, 'median', 5);
denoised_saltpepper_med7 = denoise(noisy_im_saltpepper, 'median', 7);

% Denoising image1_gaussian.jpg 
denoised_gaussian_box3 = denoise(noisy_im_gauss, 'box', 3);
denoised_gaussian_box5 = denoise(noisy_im_gauss, 'box', 5);
denoised_gaussian_box7 = denoise(noisy_im_gauss, 'box', 7);
denoised_gaussian_med3 = denoise(noisy_im_gauss, 'median', 3);
denoised_gaussian_med5 = denoise(noisy_im_gauss, 'median', 5);
denoised_gaussian_med7 = denoise(noisy_im_gauss, 'median', 7);

% Plotting denoised image1_saltpepper.jpg 
ax1 = subplot(2,3,1);
imshow(denoised_saltpepper_box3);
title(ax1,'\fontsize{16}box 3x3')

ax2 = subplot(2,3,2);
imshow(denoised_saltpepper_box5);
title(ax2,'\fontsize{16}box 5x5')

ax3 = subplot(2,3,3);
imshow(denoised_saltpepper_box7);
title(ax3,'\fontsize{16}box 7x7')

ax4 = subplot(2,3,4);
imshow(denoised_saltpepper_med3);
title(ax4,'\fontsize{16}median 3x3')

ax5 = subplot(2,3,5);
imshow(denoised_saltpepper_med5);
title(ax5,'\fontsize{16}median 5x5')

ax6 = subplot(2,3,6);
imshow(denoised_saltpepper_med7);
title(ax6,'\fontsize{16}median 7x7')

% Plotting denoised image1_gaussian.jpg 
figure;
ax1 = subplot(2,3,1);
imshow(denoised_gaussian_box3);
title(ax1,'\fontsize{16}box 3x3')

ax2 = subplot(2,3,2);
imshow(denoised_gaussian_box5);
title(ax2,'\fontsize{16}box 5x5')

ax3 = subplot(2,3,3);
imshow(denoised_gaussian_box7);
title(ax3,'\fontsize{16}box 7x7')

ax4 = subplot(2,3,4);
imshow(denoised_gaussian_med3);
title(ax4,'\fontsize{16}median 3x3')

ax5 = subplot(2,3,5);
imshow(denoised_gaussian_med5);
title(ax5,'\fontsize{16}median 5x5')

ax6 = subplot(2,3,6);
imshow(denoised_gaussian_med7);
title(ax6,'\fontsize{16}median 7x7')


% Computing PSNR for the denoised images
fprintf('PSNR between denoised image1_saltpepper.jpg and image1.jpg:\n')
disp(myPSNR(original_im, denoised_saltpepper_box3))
disp(myPSNR(original_im, denoised_saltpepper_box5))
disp(myPSNR(original_im, denoised_saltpepper_box7))
disp(myPSNR(original_im, denoised_saltpepper_med3))
disp(myPSNR(original_im, denoised_saltpepper_med5))
disp(myPSNR(original_im, denoised_saltpepper_med7))

fprintf('PSNR between denoised image1_gaussian.jpg and image1.jpg:\n')
disp(myPSNR(original_im, denoised_gaussian_box3))
disp(myPSNR(original_im, denoised_gaussian_box5))
disp(myPSNR(original_im, denoised_gaussian_box7))
disp(myPSNR(original_im, denoised_gaussian_med3))
disp(myPSNR(original_im, denoised_gaussian_med5))
disp(myPSNR(original_im, denoised_gaussian_med7))

% Denoising with Gaussian filtering
denoised_gaussian_gauss05 = denoise(noisy_im_gauss, 'gaussian', .5, 3);
denoised_gaussian_gauss1 = denoise(noisy_im_gauss, 'gaussian', 1, 3);
denoised_gaussian_gauss2 = denoise(noisy_im_gauss, 'gaussian', 2, 3);

% Plotting image1_gaussian.jpg denoised with Gaussian filtering
figure;
ax1 = subplot(1,3,1);
imshow(denoised_gaussian_gauss05);
title(ax1,'\fontsize{16}Gaussian sigma .5')

ax2 = subplot(1,3,2);
imshow(denoised_gaussian_gauss1);
title(ax2,'\fontsize{16}Gaussian sigma 1')

ax3 = subplot(1,3,3);
imshow(denoised_gaussian_gauss2);
title(ax3,'\fontsize{16}Gaussian sigma 2')

% PSNR of image1_gaussian.jpg denoised with Gaussian filtering
fprintf('PSNR between image1_gaussian.jpg denoised with Gaussian filtering and image1.jpg:\n')
disp(myPSNR(original_im, denoised_gaussian_gauss05))
disp(myPSNR(original_im, denoised_gaussian_gauss1))
disp(myPSNR(original_im, denoised_gaussian_gauss2))

