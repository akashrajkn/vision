function [im_transformed] = transform_image(im, T, filter)

    [h,w,channels] = size(im);
    M = reshape(T(1:4), [2,2]);
    corners = round([1,1; h,1; 1,w; h,w] * M);

    h_new = max(corners(2,1), corners(4,1)) - min(corners(1,1), corners(3,1)) + 1;
    w_new = max(corners(3,2), corners(4,2)) - min(corners(1,2), corners(2,2)) + 1;

    offset_h = 1-min(corners(:,1));
    offset_w = 1-min(corners(:,2));

    im_transformed = zeros(h_new, w_new, channels);

    for i = 1:h
        for j = 1:w
            ij_transformed = round([i,j]*M) + [offset_h, offset_w];
            im_transformed(ij_transformed(1), ij_transformed(2), :) = im(i, j, :);
        end
    end
    
    if filter == "median"
        im_transformed = medfilt2(im_transformed);
    end
    
    if filter == "nearest"
        for i = 1:h_new
            for j = 1:w_new
                if im_transformed(i, j, :) == [0,0,0]
                    ij_original = round(([i,j] - [offset_h, offset_w]) * inv(M));
                    
                    if ij_original(1)>0 && ij_original(2)>0 && ij_original(1) <= h && ij_original(2) <= w
                        disp(ij_original)
                        im_transformed(i, j, :) = im(ij_original(1), ij_original(2));
                    end
                end
            end
        end
    end
end