function [matchings, f1, d1, f2, d2] = keypoint_matching(image1, image2)
% Computes the keypoint matchings between the input images
% NOTE: Requires VLFeat (http://www.vlfeat.org/)
%   @param: image1
%   @param: image2
%
%   @return: keypoint matchings

    if nargin < 2
        image1 = single(imread('boat1.pgm'));
        image2 = single(imread('boat2.pgm'));
    end

    [f1, d1] = vl_sift(image1);
    [f2, d2] = vl_sift(image2);

    matchings = vl_ubcmatch(d1, d2);
end
