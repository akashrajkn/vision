function plot_ransac(image1, image2, T)
% Returns a transformation
%   @param image1 - keypoint matchings
%   @param image2
%   @param T - Transformation matrix [m1 m2 m3 m4 t1 t2]'
%
%   @return: transformation T

    [h, w] = size(image1);
    transformed_image = zeros(h, w);

    for i = 1:h
        for j = 1:w
            A = [i j 0 0 1 0; 0 0 i j 0 1];
            new_point = round(A * T);

            if new_point(1) > 0 && new_point(2) > 0 % && new_point(2) <= h && new_point(1) <= w
                transformed_image(new_point(1), new_point(2)) = image2(i, j);
            end
        end
    end

    figure;
    imshow(uint8(transformed_image))

end
