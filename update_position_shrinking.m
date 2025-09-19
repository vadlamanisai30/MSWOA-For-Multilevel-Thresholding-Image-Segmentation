function new_position = update_position_shrinking(X_star, current_position, A, omega)
    D = abs(A * X_star - current_position);
    new_position = omega * X_star - A * D;
end
