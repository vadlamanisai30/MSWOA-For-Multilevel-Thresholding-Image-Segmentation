function a = nonlinear_convergence_factor(t, Tmax, u)
    a = 2 -  * (2^(t / Tmax - 1))^u;
end
