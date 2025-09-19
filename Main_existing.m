% function mswoa_segmentation_main(img_path, method, levels, max_iter, num_whales)
    % MSWOA-based Multilevel Thresholding Image Segmentation
    % Parameters:
    % img_path: Path to the input image
    % method: 'otsu' or 'kapur' for the thresholding method
    % levels: Number of thresholds (m)
    % max_iter: Maximum number of iterations
    % num_whales: Population size
    % Example usage of MSWOA for image segmentation        
    %mswoa_segmentation_main('lena.jpg', 'otsu', 5, 100, 30);

    % Load and preprocess the image
   img = imread('baboon.png');  % Replace with your image file
levels = 10;  % Number of thresholds
num_whales = 30;  % Population size
max_iter=100;
method='otsu';
    if size(img, 3) == 3
        img = rgb2gray(img); % Convert to grayscale if needed
    end

    % Algorithm parameters
    lb = 1;                % Lower bound for thresholds
    ub = 256;              % Upper bound for thresholds
    u = 0.4;               % Nonlinear convergence factor parameter

    % Initialize whale population using k-point strategy
    k = 2; % k-point search strategy parameter
    tic
    whales = initialize_population_kpoint(num_whales, levels, lb, ub, k);

    % Evaluate initial fitness
    fitness = evaluate_fitness(img, whales, method);
    [best_fitness, best_index] = max(fitness);
    best_position = whales(best_index, :);

    % Optimization loop
    for t = 1:max_iter
        a = nonlinear_convergence_factor(t, max_iter, u);
        omega = adaptive_weight_coefficient(t, max_iter);

        for i = 1:num_whales
            A = 2 * a * rand() - a;
            p = rand();

            if p < 0.5
                if abs(A) < 1
                    % Shrinking encircling
                    whales(i, :) = update_position_shrinking(best_position, whales(i, :), A, omega);
                else
                    % Random exploration
                    random_whale = whales(randi([1 num_whales]), :);
                    whales(i, :) = update_position_random(random_whale, whales(i, :), A, omega);
                end
            else
                % Spiral updating
                whales(i, :) = update_position_spiral(best_position, whales(i, :), omega);
            end
        end

        % Ensure thresholds are within bounds
        whales = max(min(whales, ub), lb);

        % Evaluate fitness of updated population
        fitness = evaluate_fitness(img, whales, method);

        % Update best whale
        [current_best_fitness, current_best_index] = max(fitness);
        if current_best_fitness > best_fitness
            best_fitness = current_best_fitness;
            best_position = whales(current_best_index, :);
        end
    end

    % Apply optimal thresholds to segment the image
    segmented_img = segment_image(img, best_position);
  

    % Display results
    fprintf('Optimal thresholds: %s\n', mat2str(sort(round(best_position))));
    figure, imshow(img, []), title('Input Image Image');
    figure, imshow(segmented_img, []), title('Segmented Image');

    % Compute metrics
psnr_value = psnr(double(img), segmented_img);

ssim_value = ssim(img, segmented_img);
fsim_value = FeatureSIM(img, segmented_img);
  toc


% Display results
fprintf('PSNR: %.4f dB\n', psnr_value);
fprintf('SSIM: %.4f\n', ssim_value);
fprintf('FSIM: %.4f\n', fsim_value);
