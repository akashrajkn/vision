
a = createGabor(10, 0, 100, 0, 1);
b = createGabor(10, 0, 10, 0, 1);
c = createGabor(10, 0, 100, pi/2, 1);
d = createGabor(10, 0, 100, 0, 1);

figure;
% ax0 = subplot(221);
% imshowpair(a(:, :, 1), a(:, :, 2), 'montage');
% title(ax0,'\sigma = \fontsize{10}10')
% 
% ax1 = subplot(222);
% imshowpair(b(:, :, 1), b(:, :, 2), 'montage');
% title(ax1,'\sigma = \fontsize{10}3')
% 
% ax2 = subplot(223);
% imshowpair(c(:, :, 1), c(:, :, 2), 'montage');
% title(ax2,'\sigma = \fontsize{10}1')
% 
% ax3 = subplot(224);
% imshowpair(d(:, :, 1), d(:, :, 2), 'montage');
% title(ax3,'\sigma = \fontsize{10}0.5')


ax0 = subplot(131);
imshowpair(a(:, :, 1), a(:, :, 2), 'montage');
title(ax0,'\fontsize{8}Default parameters')

ax1 = subplot(132);
imshowpair(b(:, :, 1), b(:, :, 2), 'montage');
title(ax1,'\lambda = \fontsize{10}10')

ax2 = subplot(133);
imshowpair(c(:, :, 1), c(:, :, 2), 'montage');
title(ax2,'\psi = \pi / \fontsize{10}2')
