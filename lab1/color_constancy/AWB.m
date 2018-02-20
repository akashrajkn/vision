function awb (image_dir )

if nargin == 0
    image_dir = './';
end

im = imread(fullfile(image_dir, 'awb.jpg'));
im = double(im)

im_corrected = im;
chrom = im;
for channel = 1:3
    chrom(:, :, channel) = im(:, :, channel) ./ sum(im, 3) ;
end

chrom_corrected = chrom;
for channel = 1:3
    chrom_corrected(:, :, channel) = chrom(:, :, channel) / mean((mean(chrom(:, :, channel))));
    im_corrected(:, :, channel) = chrom_corrected(:, :, channel) .* im(:, :, channel);
end

ax1 = subplot(1,2,1);
imshow(uint8(im));
title(ax1,'\fontsize{16}Original image')

ax2 = subplot(1,2,2);
imshow(uint8(im_corrected));
title(ax2,'\fontsize{16}Corrected image')

disp(mean((mean(chrom_corrected))))
end
