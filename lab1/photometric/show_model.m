function show_model(albedo, height_map, folder, sim)
% SHOW_MODEL: display the model with texture
%   albedo: image used as texture for the model
%   height_map: height in z direction, describing the model geometry

save_result = true;

if nargin < 4
    save_result = false;
end

% some cosmetic transformations to make 3D model look better
[hgt, wid] = size(height_map);
[X,Y] = meshgrid(1:wid, 1:hgt);
H = rot90(fliplr(height_map), 2);
A = rot90(fliplr(albedo), 2);

figure;
mesh(H, X, Y, A);
axis equal;
xlabel('Z')
ylabel('X')
zlabel('Y')
title('Height Map')
view(-60,20)
colormap(gray)
set(gca, 'XDir', 'reverse')
set(gca, 'XTick', []);
set(gca, 'YTick', []);
set(gca, 'ZTick', []);

% save result in file
if save_result
    filepath = strcat('./results/', folder, '/heatmap_', num2str(sim), '.png');
    saveas(gcf, filepath);
end

end
