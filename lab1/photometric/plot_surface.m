function plot_surface( normals, height_map )

[X,Y] = meshgrid(1:16:512);
Z = downsample(downsample(height_map, 16)', 16)';
colormap default
surf(X, Y, Z)

V = normals(1:16:end, 1:16:end, :);
disp([size(Z), size( V(:, :, 1))])
quiver3(X, Y, Z, V(:, :, 1), V(:, :, 2), V(:, :, 3), 0.5)