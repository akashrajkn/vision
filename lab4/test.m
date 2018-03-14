
boat1 = imread('boat1.pgm');
boat2 = imread('boat2.pgm');

boat1_s = single(boat1);
boat2_s = single(boat2);

[f1, d1] = vl_sift(boat1_s);
[f2, d2] = vl_sift(boat2_s);

[matches, scores] = vl_ubcmatch(d1, d2);

perm = randperm(size(matches, 2));
sel = perm(1: 10);

matches = matches(:, sel) ;
scores  = scores(sel) ;

figure(1) ; clf ;
imshow(cat(2, boat1, boat2)) ;

% pause(5);

xa = f1(1,matches(1, :)) ;
xb = f2(1,matches(2, :)) + size(boat1_s,2) ;
ya = f1(2,matches(1, :)) ;
yb = f2(2,matches(2, :)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b') ;

vl_plotframe(f1(:,matches(1,:))) ;
f2(1,:) = f2(1,:) + size(boat1_s,2) ;
vl_plotframe(f2(:,matches(2,:))) ;
axis image off ;
