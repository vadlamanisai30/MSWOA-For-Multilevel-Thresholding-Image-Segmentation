function a = nonlinear_convergence_factor_proposed(t, Tmax, u)
    a = 1 - 1 * (2^(t / Tmax - 1))^u;
end
