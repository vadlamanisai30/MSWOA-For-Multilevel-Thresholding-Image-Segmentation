function fitR = kapur(img, xR)
    % Kapur's Entropy-Based Fitness Calculation
    % Inputs:
    % - img: Grayscale image
    % - xR: Threshold array
    % Outputs:
    % - fitR: Fitness value (sum of entropies for all classes)

    % Ensure thresholds are sorted and within valid range
    xR = sort(round(xR));         % Sort and round thresholds
    xR(xR < 1) = 1;               % Clamp to minimum valid value
    xR(xR > 256) = 256;           % Clamp to maximum valid value

    [m, level] = size(xR);

    % Image dimensions
    [M, n] = size(img);
    N = M * n; % Total number of pixels

    % Histogram and probability distribution
    [count, ~] = imhist(img, 256);
    PI = count / N; % Probability of each intensity level

    % Kapur's Entropy Method
    fitR = zeros(1, m);
    for j = 1:m
        % First class
        PI0 = PI(1:xR(j, 1));
        PI0(PI0 == 0) = eps; % Avoid log(0)
        w0 = sum(PI0);
        H0 = -sum((PI0 / w0) .* log2(PI0 / w0));
        fitR(j) = fitR(j) + H0;

        % Intermediate classes
        for jl = 2:level
            PI0 = PI(xR(j, jl-1) + 1:xR(j, jl));
            PI0(PI0 == 0) = eps; % Avoid log(0)
            w0 = sum(PI0);
            H0 = -sum((PI0 / w0) .* log2(PI0 / w0));
            fitR(j) = fitR(j) + H0;
        end

        % Last class
        PI0 = PI(xR(j, level) + 1:end);
        PI0(PI0 == 0) = eps; % Avoid log(0)
        w0 = sum(PI0);
        H0 = -sum((PI0 / w0) .* log2(PI0 / w0));
        fitR(j) = fitR(j) + H0;
    end
end
