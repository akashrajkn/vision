function plot_surface( normals, height_map )

scaling_factor = 16

[X,Y] = meshgrid(1:scaling_factor:512);
Z = downsample(downsample(height_map, scaling_factor)', scaling_factor)';
V = normals(1:scaling_factor:end, 1:scaling_factor:end, :);

% Plot
colormap default

ax1 = subplot(1,2,1);
surf(X, Y, Z)
title(ax1,'\fontsize{14}Shape')

ax2 = subplot(1,2,2);
quiver3(X, Y, Z, V(:, :, 1), V(:, :, 2), V(:, :, 3), 0.5)
title(ax2,'\fontsize{14}Normals')