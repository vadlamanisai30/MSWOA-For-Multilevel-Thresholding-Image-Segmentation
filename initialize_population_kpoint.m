function population = initialize_population_kpoint(num_whales, dim, lb, ub, k)
    % Initialize population using k-point search strategy
    population = lb + (ub - lb) * rand(num_whales, dim);
    left_population = (lb + population) / k;
    right_population = (population + ub) / k;
    extended_population = [population; left_population; right_population];
    fitness = sum(extended_population, 2); % Dummy fitness (replace if needed)
    [~, sorted_indices] = sort(fitness, 'descend');
    population = extended_population(sorted_indices(1:num_whales), :);
end
