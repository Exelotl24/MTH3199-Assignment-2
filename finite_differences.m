function dVdtheta = finite_differences(vertex_coords, leg_params, theta)

    V_root = @(theta) compute_coords(vertex_coords_guess, leg_params, theta);
    
    dVdtheta = approximate_derivative(vertex_coords_root, theta);

end 