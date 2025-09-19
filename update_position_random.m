function new_position = update_position_random(X_rand, current_position, A, omega)
    D = abs(A * X_rand - current_position);
    new_position = omega * X_rand - A * D;
end
