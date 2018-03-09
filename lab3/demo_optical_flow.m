% demo function for lucas-kanade

disp('Lucas Kanade algorithm on Sphere images')
figure;
% ax1 = subplot(1, 3, 1)
lucas_kanade('sphere1.ppm', 'sphere2.ppm');
% title(ax1, 'window: 5 * 5')

hold off;
pause(1);  % wait for 1 second

disp('Lucas Kanade algorithm on Synth images')
figure;
lucas_kanade('synth1.pgm', 'synth2.pgm');
