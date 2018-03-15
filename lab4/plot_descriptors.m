function plot_descriptors(image1, image2, matchings, f1, f2)
% Returns a transformation
%   @param matchings - keypoint matchings
%   @param f1
%   @param f2
%
%   @return: transformation T

    image1_s = single(image1);

    figure(1); clf;
    imshow(cat(2, image1, image2));

    x1 = f1(1, matchings(1, :));
    y1 = f1(2, matchings(1, :));
    x2 = f2(1, matchings(2, :)) + size(image1_s, 2);
    y2 = f2(2, matchings(2, :));

    hold on ;
    h = line([x1 ; x2], [y1 ; y2]);
    set(h, 'linewidth', 1, 'color', 'b');

    vl_plotframe(f1(:, matchings(1, :)));
    f2(1, :) = f2(1, :) + size(image1_s, 2);
    vl_plotframe(f2(:, matchings(2, :)));
    axis image off;

end
