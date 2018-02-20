function AWB ( )
% AWB performs automatic white balance adjustment using the grey-world alg

im = im2double(imread('awb.jpg'));
im_corrected = zeros(size(im));

% adjustment to the channels needed to make the mean color of the img grey
means_adj = [.5, .5, .5] ./ reshape(mean(mean(im)), [1, 3]);

% adjust each channel
for channel = 1:3
    im_corrected(:, :, channel) = im(:, :, channel) .*  means_adj(channel);
end

ax1 = subplot(1,2,1);
imshow(im);
title(ax1,'\fontsize{16}Original image')

ax2 = subplot(1,2,2);
imshow(im_corrected);
title(ax2,'\fontsize{16}Corrected image')
end
