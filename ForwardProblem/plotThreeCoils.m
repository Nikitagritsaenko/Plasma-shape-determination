function [] = plotThreeCoils(I1, I2, I16, r_in, R)    
    r0 = r_in + R;
    % 1. Plot in RZ plane
    grid_step_x = 0.01;
    grid_x = 0:grid_step_x:4*R;
    grid_step_y = 1.5 * grid_step_x;
    grid_y = -3*R:grid_step_y:3*R;
    
    MR = zeros(length(grid_x), length(grid_y));
    MZ = zeros(length(grid_x), length(grid_y));
    
    alpha = pi / 8;
    
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)  
            r = grid_x(i);
            z = grid_y(j);    
            
            phi = asin(z / sqrt(r^2 + z^2));
            dphi1 = phi - alpha;
            dphi2 = phi - (-alpha);
            
            r1 = r - r0;
            z1 = z;
            
            r2 = sqrt(r^2 + z^2) * cos(dphi1) - r0;
            z2 = sqrt(r^2 + z^2) * sin(dphi1);
    
            r16 = sqrt(r^2 + z^2) * cos(dphi2) - r0;
            z16 = sqrt(r^2 + z^2) * sin(dphi2);

            [Br1, Bz1] = findB(r1, z1, R, I1);
            [Br2, Bz2] = findB(r2, z2, R, I2);
            [Br16, Bz16] = findB(r16, z16, R, I16);

            MR(i, j) = Br1 + Br2 + Br16;
            MZ(i, j) = Bz1 + Bz2 + Bz16;
        end
    end
    
    % quiver
    figure('color', 'white');
    quiver(grid_x, grid_y, MR', MZ'); 
    line([r_in, 2*R + r_in], [0, 0], 'color', 'r', 'linewidth', 2); % coil 1
    line([r_in*cos(alpha), (r_in+2*R)*cos(alpha)], [r_in*sin(alpha),  (r_in+2*R)*sin(alpha)], 'color', 'r', 'linewidth', 2); % coil 2
    line([r_in*cos(alpha), (r_in+2*R)*cos(alpha)], [-r_in*sin(alpha), -(r_in+2*R)*sin(alpha)], 'color', 'r', 'linewidth', 2); % coil 16
    %line([r_in + R, r_in + R], [-3*R, 3*R], 'color', 'k'); % symmetric line

    axis equal;
    
    legend('vector field', 'coils');

   
end