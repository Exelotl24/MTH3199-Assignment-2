function dVdtheta = compute_velocities(vertex_coords, leg_params, theta)

    % Build Jacobian 
    F = @(V) linkage_error_func(V, leg_params, theta);
    J = numerical_jacobian(F, vertex_coords);

    % Fixed vertex derivatives
    dx1_dtheta = -leg_params.crank_length * sin(theta);
    dy1_dtheta =  leg_params.crank_length * cos(theta);
    dx2_dtheta = 0;
    dy2_dtheta = 0;

    % Make M and B
    n = length(vertex_coords);
    I4 = [eye(4), zeros(4, n - 4)];
    M = [I4; J];
    B = [dx1_dtheta; dy1_dtheta; dx2_dtheta; dy2_dtheta; zeros(size(J,1), 1)];

    % Solve for dV/dtheta
    dVdtheta = M \ B;
end
