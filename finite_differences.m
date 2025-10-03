function dVdtheta__FD = finite_differences(vertex_coords, leg_params, theta)

    V_root = @(theta) compute_coords(vertex_coords_guess, leg_params, theta);
    
    dVdtheta__FD = approximate_derivative(vertex_coords_root, theta);

end 