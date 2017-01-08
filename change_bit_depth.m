function result_im = change_bit_depth(gray_im, desired_bit_depth)
% http://dsp.stackexchange.com/questions/21835/quantization-image-using-matlab

if (desired_bit_depth < 1)
    disp('Converting to binary (1 bit) image');
    desired_bit_depth = 1;
end

if (desired_bit_depth > 8)
    disp('Converting to 8 bit image');
    desired_bit_depth = 8;
end

% Assuming we start with 8 bit image 256 levels
num_levels = 2 ^ desired_bit_depth;

% Figures out how big each range should be. We use +1 because if we
% divide the data into N levels, there should be N+1 boundaries
limits = linspace(0,256,num_levels + 1);

result_im = uint8(zeros(size(gray_im)));

for i = 1:num_levels
    lower_lim = limits(i);
    upper_lim = limits(i+1);
    
    % Creates a binary mask of values between the limits, the output is
    % 0 or 1, but we need to make it uint8 for the next step
    temp_mask = uint8((gray_im >= lower_lim) & (gray_im < upper_lim));
    
%     % Multiplies image by mask, this isolates only pixels in the given range
%     image_only_in_range = temp_mask .* gray_im;
%     % Finds the mean of that small part of the image. This weird notation
%     % is taking the average of nonzero elements
%     avg_val_for_range = round(mean(image_only_in_range(image_only_in_range~=0)));

    avg_val_for_range = round(mean([upper_lim lower_lim]));
    
    % Replaces all pixels in that range with the average value
    result_im = result_im +(avg_val_for_range * temp_mask);
end

% figure;
% subplot(1,2,1); imshow(gray_im); title('Original image');
% subplot(1,2,2); imshow(result_im); title(sprintf('Modified to %d bit image',desired_bit_depth));

end