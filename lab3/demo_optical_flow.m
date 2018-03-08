% demo function for lucas-kanade

disp('Lucas Kanade algorithm on Sphere images')
lucas_kanade('sphere1.ppm', 'sphere2.ppm');

hold off;
pause(1);  % wait for 1 second

disp('Lucas Kanade algorithm on Synth images')
lucas_kanade('synth1.pgm', 'synth2.pgm');
