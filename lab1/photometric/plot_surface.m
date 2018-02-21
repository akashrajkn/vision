function plot_surface( normals, height_map )

scaling_factor = 16
[X,Y] = meshgrid(1:scaling_factor:512);
Z = downsample(downsample(height_map, scaling_factor)', scaling_factor)';
colormap default
surf(X, Y, Z)

V = normals(1:scaling_factor:end, 1:scaling_factor:end, :);
disp([size(Z), size( V(:, :, 1))])
quiver3(X, Y, Z, V(:, :, 1), V(:, :, 2), V(:, :, 3), 0.5)