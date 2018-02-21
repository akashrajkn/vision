function iid_image_formation ()
% IID_IMAGE_FORMATION reconstucts an image from its shading and reflectance
% components.

% load input images
im_ball = imread('ball.png');
im_reflectance = imread('ball_reflectance.png');
im_shading = imread('ball_shading.png');

% reconstruct the image
im_reconstr = double(im_reflectance) .* double(im_shading);

% plotting
ax1 = subplot(2,2,1);
imshow(im_ball)
title(ax1,'\fontsize{16}Original image')

ax2 = subplot(2,2,2);
imshow(im_reflectance)
title(ax2,'\fontsize{16}Reflectance component')

ax3 = subplot(2,2,3);
imshow(im_shading)
title(ax3,'\fontsize{16}Shading component')

ax4 = subplot(2,2,4);
imshow(uint16(im_reconstr))
title(ax4,'\fontsize{16}Reconstructed image')

end