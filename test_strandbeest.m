
theta = pi/4;
vertex_coords_guess = [...
     0, 50;
    -50, 0;
    -50, 50;
   -100, 0;
   -100,-50;
    -50,-50;
    -50,-100];

V_root = compute_coords(vertex_coords_guess, leg_params, theta)
dVdtheta = compute_velocities(V_root, leg_params, theta)


vx_tip = dVdtheta(2*(7-1) + 1)
vy_tip = dVdtheta(2*(7-1) + 2)

disp(V_root);
disp("vx tip:");
disp(vx_tip);
disp("vy tip:");
disp(vy_tip);

disp("Test start");
theta = pi/4;
disp("theta set");