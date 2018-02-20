function iid_image_formation (image_dir )

if nargin == 0
    image_dir = './';
end

% read input images
im_ball = imread(fullfile(image_dir, 'ball.png'));
im_reflectance = imread(fullfile(image_dir, 'ball_reflectance.png'));
im_shading = imread(fullfile(image_dir, 'ball_shading.png'));

im_reconstr = double(im_reflectance) .* double(im_shading);

ax1 = subplot(1,4,1);
imshow(im_ball)
title(ax1,'\fontsize{16}Original image')

ax2 = subplot(1,4,2);
imshow(im_reflectance)
title(ax2,'\fontsize{16}Reflectance component')

ax3 = subplot(1,4,3);
imshow(im_shading)
title(ax3,'\fontsize{16}Shading component')

ax4 = subplot(1,4,4);
imshow(uint16(im_reconstr))
title(ax4,'\fontsize{16}Reconstructed image')

end