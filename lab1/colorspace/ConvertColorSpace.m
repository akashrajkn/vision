function [new_image] = ConvertColorSpace(input_image, colorspace, method)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Converts an RGB image into a specified color space, visualizes the
% color channels and returns the image in its new color space.
%
% Colorspace options:
%   opponent
%   rgb -> for normalized RGB
%   hsv
%   ycbcr
%   gray
%
% P.S: Do not forget the visualization part!
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if nargin == 2
    method = 'default';
end

% convert image into double precision for conversions
input_image = im2double(input_image);

if strcmp(colorspace, 'opponent')
    new_image = rgb2opponent(input_image);
elseif strcmp(colorspace, 'rgb')
    new_image = rgb2normedrgb(input_image);
elseif strcmp(colorspace, 'hsv')
    % use the built-in function
    new_image = rgb2hsv(input_image);
elseif strcmp(colorspace, 'ycbcr')
    % use the built-in function
    new_image = rgb2ycbcr(input_image);
elseif strcmp(colorspace, 'gray')
    new_image = rgb2grays(input_image, method);
else
% if user inputs an unknow colorspace just notify and do not plot anything
    fprintf('Error: Unknown colorspace type [%s]...\n',colorspace);
    new_image = input_image;
    return;
end

visualize(new_image, colorspace, input_image); % fill in this function

end
