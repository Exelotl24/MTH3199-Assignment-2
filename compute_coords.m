%Computes the vertex coordinates that describe a legal linkage configuration
%INPUTS:
%vertex_coords_guess: a column vector containing the (x,y) coordinates of every vertex
% these coords are just a GUESS! It's used to seed Newton's method
%leg_params: a struct containing the parameters that describe the linkage
%theta: the desired angle of the crank
%OUTPUTS:
%vertex_coords_root: a column vector containing the (x,y) coordinates of every vertex
% these coords satisfy all the kinematic constraints!
function vertex_coords_root = compute_coords(vertex_coords_guess, leg_params, theta)
    solver_params = struct();
    solver_params.dxmin = 1e-6;
    solver_params.ftol = 1e-6;
    solver_params.dxmax = 1e8;
    solver_params.max_iters = 500;
    solver_params.numerical_diff = 0;

    function errors = linkage_error_func_wrapper(guesses)
        errors = linkage_error_func(guesses, leg_params, theta);
    end

    vertex_coords_root = multi_newton_solver(@linkage_error_func_wrapper, vertex_coords_guess, solver_params);
end