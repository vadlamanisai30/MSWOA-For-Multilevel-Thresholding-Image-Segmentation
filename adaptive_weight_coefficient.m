function omega = adaptive_weight_coefficient(t, Tmax)
    omega = 1 - (2 / pi) * acos(t / Tmax);
end
