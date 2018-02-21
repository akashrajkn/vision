function [ albedo, normal ] = estimate_alb_nrm(image_stack, scriptV, shadow_trick, number_channels)
% COMPUTE_SURFACE_GRADIENT compute the gradient of the surface
%   image_stack : the images of the desired surface stacked up on the 3rd
%   dimension
%   scriptV : matrix V (in the algorithm) of source and camera information
%   shadow_trick: (true/false) whether or not to use shadow trick in solving linear equations

% number of dimensions in the image stack
if ndims(image_stack) == 3
    [h, w, c] = size(image_stack);
    channels = 1;
    rgb_image = false;
elseif ndims(image_stack) == 4
    [h, w, channels, c] = size(image_stack);
    rgb_image = true;
    if number_channels == 1
        gray_stack = zeros(h, w, c);
        for i = 1:c
            gray_stack(:, :, i) = rgb2gray(image_stack(:, :, :, i));
        end
    end
end

% create arrays for albedo and normals
albedo = zeros(h, w, channels);
normal = zeros(h, w, 3);

% =========================================================================
% for each point in the image array
%   stack image values into a vector i
%   construct the diagonal matrix scriptI
%   solve scriptI * scriptV * g = scriptI * i to obtain g for this point
%   albedo at this point is |g|
%   normal at this point is g / |g|

% for p = 1:h
%     for q = 1:w
%         i = reshape(image_stack(p, q, :), [n, 1]);
%
%         if shadow_trick
%             scriptI = diag(i);
%             [g, ~] = linsolve(scriptI * scriptV,  scriptI * i);
%         else
%             [g, ~] = linsolve(scriptV, i);
%         end
%
%         albedo(p, q) = norm(g);
%         normal(p, q, :) = g / norm(g);
%     end
% end

for p = 1:h
    for q = 1:w
        % RGB IMAGE
        if rgb_image
            temp_image = squeeze(image_stack(p, q, :, :));
            r_xy = temp_image(1, :);
            g_xy = temp_image(2, :);
            b_xy = temp_image(3, :);

            if number_channels == 1
                i = squeeze(gray_stack(p, q, :));
            elseif number_channels == 2
                i = r_xy';
            end

            if shadow_trick
                if number_channels == 3
                    I_r = diag(r_xy);
                    I_g = diag(g_xy);
                    I_b = diag(b_xy);
                    [g_r, ~]  = linsolve(I_r * scriptV, I_r * r_xy');
                    [g_g, ~]  = linsolve(I_g * scriptV, I_g * g_xy');
                    [g_b, ~]  = linsolve(I_b * scriptV, I_b * b_xy');
                else
                    I = diag(i);
                    [g, ~]  = linsolve(I * scriptV, I * i);
                end
            else
                if number_channels == 3
                    [g_r, ~]  = linsolve(scriptV, r_xy');
                    [g_g, ~]  = linsolve(scriptV, g_xy');
                    [g_b, ~]  = linsolve(scriptV, b_xy');
                else
                    [g, ~]  = linsolve(scriptV, i);
                end
            end

            if number_channels == 3
                max_norm = max([norm(g_r), norm(g_g), norm(g_b)]);

                if norm(g_r) == max_norm
                    normal(p, q, :) = g_r / norm(g_r);
                elseif norm(g_g) == max_norm
                    normal(p, q, :) = g_g / norm(g_g);
                else
                    normal(p, q, :) = g_b / norm(g_b);
                end
            else
                normal(p, q, :) = g / norm(g);
                N = g / norm(g);
            end

            switch number_channels
                case 1
                    k_r = sum((r_xy * scriptV * N)) / sum((scriptV * N) .^ 2);
                    k_g = sum((g_xy * scriptV * N)) / sum((scriptV * N) .^ 2);
                    k_b = sum((b_xy * scriptV * N)) / sum((scriptV * N) .^ 2);
                    albedo(p, q, :) = [k_r k_g k_b];

                case 2
                    k_r = norm(g);
                    k_g = sum((g_xy * scriptV * N)) / sum((scriptV * N) .^ 2);
                    k_b = sum((b_xy * scriptV * N)) / sum((scriptV * N) .^ 2);
                    albedo(p, q, :) = [k_r k_g k_b];
                case 3
                albedo(p, q, :) = [norm(g_r) norm(g_g) norm(g_b)];
            end
        else
            i = squeeze(image_stack(p, q, :));
            if shadow_trick
                I = diag(i);  % construct the diagonal matrix I
                [g, ~]  = linsolve(I * scriptV, I * i);
            else
                [g, ~]  = linsolve(scriptV, i);
            end

            albedo(p, q, 1) = norm(g);
            normal(p, q, :) = g / albedo(p, q, 1);
        end
    end
end

% =========================================================================

end
