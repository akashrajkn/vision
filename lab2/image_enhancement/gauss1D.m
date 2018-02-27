function G = gauss1D(sigma, kernel_size)
% 1-D Gaussian filter
% @param sigma: variance of the Gaussian
% @param kernel_size: size of the convolutional kernel
%
% @return G: 1-D Gaussian filter matrix

    G = zeros(1, kernel_size);

    if mod(kernel_size, 2) == 0
        error('kernel_size must be odd, otherwise the filter will not have a center to convolve on')
    end

    x_values = ceil(-kernel_size / 2):1:floor(kernel_size / 2);
    g = exp(-x_values.^2 / (2 * sigma ^ 2)) / (sigma * sqrt(2 * pi));

    % normalize the filter
    G = g ./ sum(g);
end
