function [T] = RANSAC(matchings, f1, f2, N, P)
% Returns a transformation
%   @param matchings - keypoint matchings
%   @param f1
%   @param f2
%   @param N - number of iterations for RANSAC
%   @param P - subset of matchings to use in RANSAC
%
%   @return: transformation T

    x1 = f1(1, matchings(1, :));
    y1 = f1(2, matchings(1, :));
    x2 = f2(1, matchings(2, :));
    y2 = f2(2, matchings(2, :));

    x1_t = x1';
    y1_t = y1';

    zer = zeros(size(x1_t));
    one = ones(size(x1_t));
    A_n = [x1_t y1_t zer zer one zer; zer zer x1_t y1_t zer one];
    num_p = size(matchings, 2);  % number of points
    
    best_transformation = [];
    best_count = 0;

    for iteration = 1:N
        % sample P points
        perm = randperm(size(matchings, 2));
        sel = perm(1:P);
        matchings_p = matchings(:, sel);
        T = compute_transformation(matchings_p, f1, f2);
        new_points = A_n * T;

        % count inliers;
        count = 0;
        for i = 1:num_p
            p1_x = new_points(i);
            p1_y = new_points(num_p + i);

            p2_x = x2(i);
            p2_y = y2(i);

            dist = sqrt((p1_x - p2_x) ^ 2 + (p1_y - p2_y) ^ 2);  % Use Euclidean distance

            if dist <= 10
                count = count + 1;
            end
        end

        if count > best_count
            best_count = count;
            best_transformation = T;
        end
    end

    disp("Best transformation is: ")
    disp(best_transformation)

end


function [T] = compute_transformation(matchings, f1, f2)
% Returns a transformation
%   @param matchings - keypoint matchings
%   @param f1
%   @param f2
%
%   @return: transformation T

    x1 = f1(1, matchings(1, :))';
    y1 = f1(2, matchings(1, :))';
    x2 = f2(1, matchings(2, :))';
    y2 = f2(2, matchings(2, :))';

    zer = zeros(size(x1));
    one = ones(size(x1));

    A = [x1 y1 zer zer one zer; zer zer x1 y1 zer one];
    b = [x2; y2];

    T = pinv(A) * b;

end

