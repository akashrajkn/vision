function [image_transformed] = transform_image(image, T, filter)

    [h,w] = size(image);
    M = reshape(T(1:4), [2,2]);
    corners = round([1,1; h,1; 1,w; h,w] * M)

    h_new = max(corners(2,1), corners(4,1)) - min(corners(1,1), corners(3,1))+1;
    w_new = max(corners(3,2), corners(4,2)) - min(corners(1,2), corners(2,2))+1;

    offset_h = 1-min(corners(:,1))
    offset_w = 1-min(corners(:,2))

    image_transformed = zeros(h_new, w_new);

    for i = 1:h
        for j = 1:w
            new_point = round([i,j]*M) + [offset_h, offset_w];
            image_transformed(new_point(1), new_point(2)) = image(i, j);
        end
    end
    if filter == 'medi'
        image_transformed = medfilt2(image_transformed);
    end
end