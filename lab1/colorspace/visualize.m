function visualize(input_image, colorspace, original_image)
% Visualize the image in different colorspaces

figure;

if strcmp(colorspace, 'gray')
    imshow(input_image)
else
    subplot(2, 2, 1)
    imshow(original_image)

    for i = 1:3
       subplot(2, 2, i+1);
       imshow(input_image(:, :, i));
    end
end

end
