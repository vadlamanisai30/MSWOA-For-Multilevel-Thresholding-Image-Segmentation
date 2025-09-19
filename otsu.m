function [fitness, thresholds] = otsu(I, thresholds)
    % Otsu Thresholding Fitness Calculation
    % Inputs:
    % - I: Grayscale image
    % - thresholds: Array of threshold values
    % Outputs:
    % - fitness: Fitness value (Otsu's objective function value)
    % - thresholds: Sorted and clamped threshold values

    % Ensure thresholds are sorted and within valid range
    thresholds = sort(round(thresholds));    % Sort and round thresholds
    thresholds(thresholds < 1) = 1;          % Clamp to minimum valid value
    thresholds(thresholds > 256) = 256;      % Clamp to maximum valid value

    % Compute histogram of the image
    searchSpace = imhist(I);
    spaceSize = size(searchSpace, 1);
    totalPixels = sum(searchSpace);

    % Probability of each gray level
    p = searchSpace ./ totalPixels;

    % Mean probability (for within-class variance calculation)
    ip = p .* linspace(1, spaceSize, spaceSize)';

    % Initialize variables
    omega = zeros(length(thresholds) + 1, 1); % Class occurrence probabilities
    mu = zeros(length(thresholds) + 1, 1);    % Class mean probabilities
    sigmasq = zeros(length(thresholds) + 1, 1); % Class variances
    threshStart = 0; % Start of current threshold range

    % Calculate class probabilities and means
    for thr = 1:length(thresholds) + 1
        if thr == length(thresholds) + 1
            threshEnd = spaceSize; % For the last class
        else
            threshEnd = thresholds(thr);
        end

        % Class occurrence probability
        omega(thr) = sum(p(threshStart + 1:threshEnd));
        if omega(thr) == 0
            mu(thr) = 0;
        else
            % Class mean probability
            mu(thr) = sum(ip(threshStart + 1:threshEnd)) / omega(thr);
        end

        % Update start of next threshold range
        threshStart = threshEnd;
    end

    % Total mean
    mu_total = sum(ip);

    % Calculate between-class variance
    for thr = 1:length(thresholds) + 1
        sigmasq(thr) = omega(thr) * (mu(thr) - mu_total)^2;
    end

    % Fitness is the sum of between-class variances
    fitness = sum(sigmasq);
end
