function dVdtheta__FD = finite_differences(vertex_coords, leg_params, theta)
    % define V_root function
    V_root = @(theta) compute_coords(vertex_coords, leg_params, theta);
    
    % use approximate derivative to implement finite difference calculation
    dVdtheta__FD = approximate_derivative(V_root, theta);

end 