% Initial guess
clear
close all

strandbeest()

return;
% ------------------- TESTING JACOBIAN FUNCTION --------------------------
X0 = rand(3, 1);

[~, J_analytical] = test_function01(X0);
J_numerical = approximate_jacobian(@test_function01, X0);

test_numerical_jacobian();
disp('Tests Passed')

% ------------------ TESTING MULTI_NEWTON_SOLVER -------------------------
Xguess = rand(3, 1);

solver_params = struct();
solver_params.dxmin = 1e-10;
solver_params.ftol = 1e-10;
solver_params.dxmax = 1e8;
solver_params.max_iters = 200;
solver_params.numerical_diff = 0;

X_root_analytical = multi_newton_solver(@test_function01, Xguess, solver_params);
f_root_analytical = test_function01(X_root_analytical);
disp(norm(f_root_analytical))

solver_params.numerical_diff = 1;
X_root_numerical = multi_newton_solver(@test_function01, Xguess, solver_params);
f_root_numerical = test_function01(X_root_numerical);
disp(norm(f_root_numerical))


% ------------------ FINDING ROOT OF TEST_FUNCTION02 ---------------------

X_root_02 = multi_newton_solver(@test_function02, Xguess, solver_params);
f_root_02 = test_function02(X_root_02);
disp(norm(f_root_02))


% ------------------- ANIMATION COLLISION TESTING ------------------------

solver_params.numerical_diff = 0;
x_guess =  [0.52; 3];

[x, exit_flag] = multi_newton_solver(@projectile_target_traj, x_guess, solver_params);

if exit_flag
    run_simulation(x(1), x(2))
end