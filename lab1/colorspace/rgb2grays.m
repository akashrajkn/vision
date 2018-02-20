function [output_image] = rgb2grays(input_image, method)
% converts an RGB into grayscale by using 4 different methods

if nargin == 1
    method = 'default'
end

[R, G, B] = getColorChannels(input_image);

switch method
    case 'lightness'
        % ligtness method
        output_image = (max(input_image, [], 3) + min(input_image, [], 3)) / 2
    case 'average'
        % average method
        output_image = (R + G + B) / 3;
    case 'luminosity'
        % luminosity method
        output_image = R * 0.21 + G * 0.72 + B * 0.07;
    case 'default'
        % built-in MATLAB function
        output_image = rgb2gray(input_image);
end

end
