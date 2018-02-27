function [ PSNR ] = myPSNR( orig_image, approx_image )
RMSE = sqrt(mean(mean((orig_image - approx_image).^2)));
PSNR = 20 * log10(max(max(orig_image))/ RMSE);
end

