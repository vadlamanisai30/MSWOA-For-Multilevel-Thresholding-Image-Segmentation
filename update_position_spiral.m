function new_position = update_position_spiral(X_star, current_position, omega)
    b = 1;
    l = -1 + 2 * rand();
    D_prime = abs(X_star - current_position);
    new_position = D_prime * exp(b * l) * cos(2 * pi * l) + (1 - omega) * X_star;
end
