
% clear all;

im1 = im2double(rgb2gray(imread('sphere1.ppm')));
im2 = im2double(rgb2gray(imread('sphere2.ppm')));

window_size = 15;
h_w = round(window_size/2);

filter = [-1 1; -1 1];
% for each point, calculate I_x, I_y, I_t
Ix_m = conv2(im1, filter, 'valid');  % partial
Iy_m = conv2(im1, filter, 'valid');  % partial
It_m = conv2(im1, ones(2), 'valid') + conv2(im2, -ones(2), 'valid');  % partial derivative with respect to t

% flow vecotrs
u = zeros(size(im1));
v = zeros(size(im2));

% within window window_size * window_size
for i = h_w+1:size(Ix_m,1)-h_w
   for j = h_w+1:size(Ix_m,2)-h_w
      Ix = Ix_m(i - h_w : i + h_w, j - h_w : j + h_w);
      Iy = Iy_m(i - h_w : i + h_w, j - h_w : j + h_w);
      It = It_m(i - h_w : i + h_w, j - h_w : j + h_w);

      Ix = Ix(:);
      Iy = Iy(:);
      b = -It(:); % get b here

      A = [Ix Iy]; % get A here
      nu = pinv(A)*b; % get velocity here

      u(i, j)=nu(1);
      v(i, j)=nu(2);
   end;
end;

Vx = zeros(size(interest_x, 1), 1);
Vy = zeros(size(interest_x, 1), 1);

for i = 1:size(interest_x, 1)
    Vx(i) = u(interest_x(i), interest_y(i));
    Vy(i) = v(interest_x(i), interest_y(i));
end

% % downsize u and v

figure();
imshow(imread('sphere1.ppm'));
hold on;
% draw the velocity vectors
quiver(interest_y, interest_x, Vx, Vy, 'w');
