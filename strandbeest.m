function leg_params = strandbeest()

    %initialize leg_params structure
    leg_params = struct();
    %number of vertices in linkage
    leg_params.num_vertices = 7;
    %number of links in linkage
    leg_params.num_linkages = 10;
    %matrix relating links to vertices
    leg_params.link_to_vertex_list = ...
        [ 1, 3;... %link 1 adjacency
            3, 4;... %link 2 adjacency
            2, 3;... %link 3 adjacency
            2, 4;... %link 4 adjacency
            4, 5;... %link 5 adjacency
            2, 6;... %link 6 adjacency
            1, 6;... %link 7 adjacency
            5, 6;... %link 8 adjacency
            5, 7;... %link 9 adjacency
            6, 7 ... %link 10 adjacency
            ];

    %list of lengths for each link
    %in the leg mechanism
    leg_params.link_lengths = ...
        [   50.0,... %link 1 length
            55.8,... %link 2 length
            41.5,... %link 3 length
            40.1,... %link 4 length
            39.4,... %link 5 length
            39.3,... %link 6 length
            61.9,... %link 7 length
            36.7,... %link 8 length
            65.7,... %link 9 length
            49.0 ... %link 10 length
            ];


    %length of crank shaft
    leg_params.crank_length = 15.0;
    %fixed position coords of vertex 0
    leg_params.vertex_pos0 = [0;0];
    %fixed position coords of vertex 2
    leg_params.vertex_pos2 = [-38.0;-7.8];

    %column vector of initial guesses
    %for each vertex location.
    %in form: [x1;y1;x2;y2;...;xn;yn]
    vertex_coords_guess = [...
        [ 0; 50];... %vertex 1 guess
        [ -50; 0];... %vertex 2 guess
        [ -50; 50];... %vertex 3 guess
        [-100; 0];... %vertex 4 guess
        [-100; -50];... %vertex 5 guess
        [ -50; -50];... %vertex 6 guess
        [ -50; -100]... %vertex 7 guess
        ];
   
    % define the list of angles to parse through
    theta_list = linspace(0, 6*pi, 250);

    % compute the initial vertex coordinates
    coord_roots = compute_coords(vertex_coords_guess, leg_params, pi/2);

    % initialize leg drawing and add-ons
    leg_drawing = initialize_leg_drawing(leg_params);
    leg_drawing.la_velocity = line([0,0],[0,0],'color','r','linewidth',0.5);
    leg_drawing.fd_velocity = line([0,0],[0,0],'color','b','linewidth',0.5, 'linestyle', '--');
    leg_drawing.tip_path = line(0, 0, 'color','k','linewidth',0.5, 'linestyle', '--');
    tip_path_coords = [];

    % initialize velocities lists
    dVdtheta_LA_list = zeros(length(theta_list), 2);
    dVdtheta_FD_list = zeros(length(theta_list), 2);

    % wait for figure to load
    pause(1)

    for i = 1:length(theta_list)
        % update drawing figure
        update_leg_drawing(coord_roots, leg_drawing, leg_params);
        
        % calculate velocity of tip
        dVdtheta_LA = column_to_matrix(compute_velocities(coord_roots, leg_params, theta_list(i)));
        dVdtheta_LA_list(i, :) = dVdtheta_LA(7, :);
        dVdtheta_FD = column_to_matrix(finite_differences(coord_roots, leg_params, theta_list(i)));
        dVdtheta_FD_list(i, :) = dVdtheta_FD(7, :);
        root_matrix = column_to_matrix(coord_roots);
        tip_path_coords = [tip_path_coords; root_matrix(7, :)];

        % update drawing with tip velocity and path
        set(leg_drawing.la_velocity, 'xdata', [root_matrix(7, 1), root_matrix(7, 1)+dVdtheta_LA(7, 1)], 'ydata', [root_matrix(7, 2), root_matrix(7, 2)+dVdtheta_LA(7, 2)])
        set(leg_drawing.fd_velocity, 'xdata', [root_matrix(7, 1), root_matrix(7, 1)+dVdtheta_FD(7, 1)], 'ydata', [root_matrix(7, 2), root_matrix(7, 2)+dVdtheta_FD(7, 2)])
        set(leg_drawing.tip_path, 'xdata', tip_path_coords(:, 1), 'ydata', tip_path_coords(:, 2))

        % compute new vertex coordinates
        coord_roots = compute_coords(coord_roots, leg_params, theta_list(i));

        % pause for animation duration
        pause(0.01)
    end

    % plot tip velocities
    figure()
    hold on
    plot(theta_list, dVdtheta_LA_list(:, 1), 'r', 'DisplayName', 'linear x velocity')
    plot(theta_list, dVdtheta_LA_list(:, 2), 'b', 'DisplayName', 'linear y velocity')
    plot(theta_list, dVdtheta_FD_list(:, 1), 'y', 'DisplayName', 'fd x velocity')
    plot(theta_list, dVdtheta_FD_list(:, 2), 'g', 'DisplayName', 'fd x velocity')
    legend()
    title(['Velocity vs Angle' ...
        ''])
    ymin = -50;
    ymax = 30;
    xmin = 0;
    xmax = 19;
    xlabel('theta (radians)')
    ylabel('velocity')




end