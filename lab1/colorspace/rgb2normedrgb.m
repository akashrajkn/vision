function [output_image] = rgb2normedrgb(input_image)
% converts an RGB image into normalized rgb

[R, G, B] = getColorChannels(input_image);

color_sum = R + G + B;

R_n = R ./ color_sum;
G_n = G ./ color_sum;
B_n = B ./ color_sum;

output_image = cat(3, R_n, G_n, B_n);

end
