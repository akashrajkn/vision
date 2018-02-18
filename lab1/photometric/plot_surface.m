function plot_surface( height_map )

[X,Y] = meshgrid(1:16:512);
colormap default
surf(X, Y, downsample(downsample(height_map, 16)', 16)')