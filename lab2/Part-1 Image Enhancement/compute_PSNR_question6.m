original_im = im2double(imread('./images/image1.jpg'));
noisy_im_saltpepper = im2double(imread('./images/image1_saltpepper.jpg'));
noisy_im_gauss = im2double(imread('./images/image1_gaussian.jpg'));

fprintf('PSNR between image1_saltpepper.jpg and image1.jpg:\n')
disp(myPSNR(original_im, noisy_im_saltpepper))

fprintf('PSNR between image1_gaussian.jpg and image1.jpg:\n')
disp(myPSNR(original_im, noisy_im_gauss))