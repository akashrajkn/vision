function imOut = compute_LoG(image, LOG_type)

switch LOG_type
    case 1
        %method 1
        f_gauss = fspecial('gaussian', 5, .5);
        f_laplassian = fspecial('laplacian'); 
        
        smoothed = imfilter(image, f_gauss, 'replicate', 'conv');
        imOut = imfilter(smoothed, f_laplassian, 'replicate', 'conv');
    case 2
        %method 2
        f_LoG = fspecial('log', 5, .5);
        imOut = imfilter(image, f_LoG, 'replicate', 'conv');
    case 3
        %method 3
        f_gauss1 = fspecial('gaussian', 5, .8);
        f_gauss2 = fspecial('gaussian', 5, .5);
        imOut = imfilter(image, f_gauss1 - f_gauss2, 'replicate', 'conv');
end
end

