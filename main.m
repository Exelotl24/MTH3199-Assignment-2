% Initial guess
clear
close all


strandbeest();

return;


theta = pi/4;
vertex_coords_guess = [...
     0; 50;
    -50; 0;
    -50; 50;
   -100; 0;
   -100;-50;
    -50;-50;
    -50;-100];

x7_LA = [];
y7_LA = [];
x7_FD = [];
y7_FD = [];
theta_list = linspace(0, 2*pi, 100);

for theta = theta_list
    V_root = compute_coords(vertex_coords_guess, leg_params, theta)
    dVdtheta_LA = column_to_matrix(compute_velocities(V_root, leg_params, theta))
    dVdtheta_FD = column_to_matrix(finite_differences(V_root, leg_params, theta))

    x7_LA = [x7_LA; dVdtheta_LA(7, 1)];
    y7_LA = [y7_LA; dVdtheta_LA(7, 2)];

    x7_FD = [x7_FD; dVdtheta_FD(7, 1)];
    y7_FD = [y7_FD; dVdtheta_FD(7, 2)];


end

figure()
hold on;
plot(x7_LA, theta_list)
plot(x7_FD, theta_list)
hold off;

figure()
hold on;
plot(y7_LA, theta_list)
plot(y7_FD, theta_list)
hold off;

% vx_tip = dVdtheta(13)
% vy_tip = dVdtheta(14)
% 


return;
% ------------------- TESTING JACOBIAN FUNCTION --------------------------
X0 = rand(3, 1);

[~, J_analytical] = test_function01(X0);
J_numerical = approximate_jacobian(@test_function01, X0);

test_numerical_jacobian();
disp('Tests Passed');

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

% -------------------- COMPUTE COORDS/VELOCITIES -------------------------


