% Convert image frames to video

type = 'pingpong';


workingDir = strcat('results/tracking_', type, '/');
imageNames = dir(fullfile(workingDir, '*.jpg'));
% imageNames = {imageNames.name}';

outputFile = strcat('tracking_', type, '.avi');
outputVideo = VideoWriter(outputFile);
outputVideo.FrameRate = 15;
open(outputVideo)

for ii = 1:length(imageNames)
   file_name = sprintf('%d.jpg', ii);
   img = imread(fullfile(workingDir, file_name));

   if strcmp(type, 'pingpong')
       img = img(1:517, 1:825, :);
   else
       img = img(1:1042, 1:1400, :);
   end

   writeVideo(outputVideo, img)
end

close(outputVideo)
