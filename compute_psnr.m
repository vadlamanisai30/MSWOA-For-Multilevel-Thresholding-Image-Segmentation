function psnr_value = compute_psnr(original_img, segmented_img)
    % Compute PSNR between original and segmented image
    % Inputs:
    % - original_img: Original grayscale image
    % - segmented_img: Segmented grayscale image
    % Output:
    % - psnr_value: Peak Signal-to-Noise Ratio value

    mse = mean((double(original_img) - double(segmented_img)).^2, 'all');
    if mse == 0
        psnr_value = Inf; % If MSE is 0, PSNR is infinite
    else
        max_pixel = 255; % Maximum pixel value for 8-bit images
        psnr_value = 10 * log10((max_pixel^2) / mse);
    end
end
