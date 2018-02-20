function recoloring(input_image_path, reflectance_image_path, shading_image_path)
% RECOLORS the original image using shading and reflectance
%    returns ball images in green and magenta colors

if nargin == 0
    input_image_path = './ball.png';
    reflectance_image_path = './ball_reflectance.png';
    shading_image_path = './ball_shading.png';
end

input_image = imread(input_image_path);
reflectance = imread(reflectance_image_path);
shading = imread(shading_image_path);

% Find the true color of the ball. We are currently using ball_reflectance.
% If unavailable, we can calculate the albedo of the image and use that.
true_color = zeros(1, 3);
for i = 1:3
    % R, G, B values of the true color
    val = unique(reflectance(:, :, i));
    val(val == 0) = [];  % Remove 0 values
    true_color(i) = mean(val);
end

% Print true color values
g = sprintf('%d ', true_color);
fprintf('True color of the original image [ R G B ] = [ %s]\n', g)

% 1. Recolor the object to green color
color = reflectance;
color(:, :, 1) = 0;
color(:, :, 3) = 0;
color(color > 0) = 255;

recolored_image_green = double(shading) .* double(color);

% 2. Recolor the object to magenta color
color = reflectance;
color(:, :, 2) = 0;
color(color > 0) = 255;

recolored_image_magenta = double(shading) .* double(color);

% Plot
ax1 = subplot(1,3,1);
imshow(input_image)
title(ax1,'\fontsize{14}Original image')

ax2 = subplot(1,3,2);
imshow(uint16(recolored_image_green))
title(ax2,'\fontsize{14}Recolored - Green')

ax3 = subplot(1,3,3);
imshow(uint16(recolored_image_magenta))
title(ax3,'\fontsize{14}Recolored - Magenta')

end
