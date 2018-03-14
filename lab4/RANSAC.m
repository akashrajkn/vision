function [T] = RANSAC(matchings, f1, f2)
% Returns a transformation
%   @param: image1
%   @param: image2
%
%   @return: keypoint matchings

    x1 = f1(1, matchings(1, :));
    y1 = f1(2, matchings(1, :));
    x2 = f2(1, matchings(2, :));
    y2 = f2(2, matchings(2, :));

    x1 = x1';
    y1 = y1';
    x2 = x2';
    y2 = y2';

    zer = zeros(size(x1));
    one = ones(size(x1));

    A = [x1 y1 zer zer one zer; zer zer x1 y1 zer one];
    b = [x2; y2];

    T = pinv(A) * b;

end
