function fitness = evaluate_fitness(img, whales, method)
    num_whales = size(whales, 1);
    fitness = zeros(num_whales, 1);

    for i = 1:num_whales
        thresholds = sort(round(whales(i, :))); % Sort and round thresholds
        thresholds(thresholds < 1) = 1;         % Lower bound
        thresholds(thresholds > 256) = 256;     % Upper bound

        if strcmp(method, 'otsu')
            [fitness(i), ~] = otsu(img, thresholds);
        elseif strcmp(method, 'kapur')
            fitness(i) = kapur(img, thresholds);
        end
    end
end
