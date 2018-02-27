function G = gauss2D(sigma, kernel_size)
% 2-D Gaussian Filter - Uses the Gaussian 1-D filter implementation
% @param sigma: variance of the Gaussian
% @param kernel_size: size of the convolutional kernel
%
% @return G: 2-D Gaussian filter matrix

    g_x = gauss1D(sigma, kernel_size);
    g_y = gauss1D(sigma, kernel_size);

    G = transpose(g_x) * g_y;

end
