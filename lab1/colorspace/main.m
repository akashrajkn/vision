clear
clc
close all

I = imread('peppers.png');

opponent = ConvertColorSpace(I, 'opponent');

close all
rgb = ConvertColorSpace(I, 'rgb');

close all
hsv = ConvertColorSpace(I, 'hsv');

close all
ycbcr = ConvertColorSpace(I, 'ycbcr');

close all
gray = ConvertColorSpace(I, 'gray');

close all
figure

x0 = subplot(2, 3, 1);
imshow(I);
title(x0,'\fontsize{14}Original image')

x1 = subplot(2, 3, 2);
imshow(opponent);
title(x1,'\fontsize{14}Opponent')

x2 = subplot(2, 3, 3);
imshow(rgb);
title(x2,'\fontsize{14}Normalized rgb')

x3 = subplot(2, 3, 4);
imshow(hsv);
title(x3,'\fontsize{14}HSV')

x4 = subplot(2, 3, 5);
imshow(ycbcr);
title(x4,'\fontsize{14}YCbCr')

x5 = subplot(2, 3, 6);
imshow(gray);
title(x5,'\fontsize{14}Grayscale')


% % Comparing grayscale methods
% default = ConvertColorSpace(I, 'gray', 'default');
% lightness = ConvertColorSpace(I, 'gray', 'lightness');
% average = ConvertColorSpace(I, 'gray', 'average');
% luminosity = ConvertColorSpace(I, 'gray', 'luminosity');
%
% % Plot
% figure
% ax1 = subplot(2, 2, 1);
% imshow(default);
% title(ax1,'\fontsize{14}Matlab')
%
% ax2 = subplot(2, 2, 2);
% imshow(lightness);
% title(ax2,'\fontsize{14}Lightness method')
%
% ax3 = subplot(2, 2, 3);
% imshow(average);
% title(ax3,'\fontsize{14}Average method')
%
% ax3 = subplot(2, 2, 4);
% imshow(luminosity);
% title(ax3,'\fontsize{14}Luminosity method')
