function [H, row, col] = harris_corner_detector(image, sigma, n, threshold)

[h, w] = size(image);
% Sobel kernels approximate the first derivatives of a Gaussian filter.
Ix, Iy = imgradientxy(image, 'sobel');

% Computing elements of Q for each pixel
% Padding type "replicate" to avoid finding extra gradient on the borders
A = imgaussfilt((Ix.^2), sigma, 'FilterSize', 5, 'Padding', 'replicate');
B = imgaussfilt((Ix.*Iy), sigma, 'FilterSize', 5, 'Padding', 'replicate');
C = imgaussfilt((Iy.^2), sigma, 'FilterSize', 5, 'Padding', 'replicate');

H = (A.*C - B.^2) - .04*((A + C).^2);

% Non-maximum supression
% Pad H with zeros
H_padded = padarray(H, [n,n]);
% Compute H_local_max_mask, where an element equals 1 if the element of
% H in the corresponding position is a local maximum, and equals zero
% otherwise
H_local_max_mask = zeros([h,w]);
for i=1+n:h+n
    for j=1+n:w+n
        if H_padded(i, j) == max(max(H_padded(i-n:i+n, i-n:i+n))) && H_padded(i, j) > threshold
           H_local_max_mask(i-n, j-n) = 1;
        end
    end
end
% Indices of nonzero elements of H_local_max_mask
[row,col] = find(H_local_max_mask);
end

