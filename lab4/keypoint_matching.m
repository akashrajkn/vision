function [matchings] = keypoint_matching(image1, image2)
% Computes the keypoint matchings between the input images
% NOTE: Requires VLFeat (http://www.vlfeat.org/)
%   @param: image1
%   @param: image2
%
%   @return: keypoint matchings

    if nargin < 2
        image1 = imread('boat1.pgm');
        image2 = imread('boat2.pgm');
    end

    % convert to type single
    boat1_s = single(boat1);
    boat2_s = single(boat2);

    [f1, d1] = vl_sift(boat1_s);
    [f2, d2] = vl_sift(boat2_s);

    matchings = vl_ubcmatch(d1, d2);
end
