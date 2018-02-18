pic_folders = ["SphereGray5", "SphereGray25"]%, "MonkeyGray", "MonkeyColor", "SphereColor"]  %, "yaleB02"]

for i = 1:size(pic_folders, 2)

    % obtain many images in a fixed view under different illumination
    disp(pic_folders(i))
    image_dir = strcat('./', char(pic_folders(i)), '/')

    % number of images in the folder
    nfiles = length(dir(fullfile(image_dir, '*.png')));
    threshold = 0.005;
    outliers_matrix = zeros(nfiles, 1);

    for sim = 3:nfiles

        [image_stack, scriptV] = load_syn_images(image_dir, 1, sim);
        [h, w, n] = size(image_stack);

        % compute the surface gradient from the stack of imgs and light source mat
        [albedo, normals] = estimate_alb_nrm(image_stack, scriptV);

        %% integrability check: is (dp / dy  -  dq / dx) ^ 2 small everywhere?
        [p, q, SE] = check_integrability(normals);

        SE(SE <= threshold) = NaN; % for good visualization
        outliers_matrix(sim, 1) = sum(sum(SE > threshold));

        %% compute the surface height
        height_map = construct_surface( p, q );

        %% Display
        show_results(albedo, normals, SE, char(pic_folders(i)), sim);
        show_model(albedo, height_map, char(pic_folders(i)), sim);
        close all
    end

    csvfilename = strcat('./results/', char(pic_folders(i)), '/outliers.csv');
    csvwrite(csvfilename, outliers_matrix)

end
