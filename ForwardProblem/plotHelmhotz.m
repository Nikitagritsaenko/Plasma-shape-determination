function [] = plotHelmhotz(I1, I2, I3, D, R)    
    
    % 1. Plot in RZ plane
    H = D / 2;
    grid_step_x = 0.1;
    grid_x = -1.5*R:grid_step_x:1.5*R;
    grid_step_y = 3 * H / (3 * R) * grid_step_x;
    grid_y = -1.5*H:grid_step_y:1.5*H;
    
    MR = zeros(length(grid_x), length(grid_y));
    MZ = zeros(length(grid_x), length(grid_y));
      
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)  
            r = grid_x(i);
            z = grid_y(j);    

            [Br1, Bz1, ~] = findB(r, z - H, R, I1);
            [Br2, Bz2, ~] = findB(r, z + H, R, I2);
            
            if (I3 ~= 0)
                [Br3, Bz3, ~] = findB(r, z, R, I3);
            end
            
            MR(i, j) = Br1 + Br2;
            MZ(i, j) = Bz1 + Bz2;
            
            if (I3 ~= 0)
                MR(i, j) = MR(i, j) + Br3;
                MZ(i, j) = MZ(i, j) + Bz3;
            end
        end
    end
    
    % quiver
    figure('color', 'white');
    quiver(grid_x, grid_y, MR', MZ'); 
    line([-R, R], [H, H], 'color', 'r', 'linewidth', 2); % coil 1
    line([-R, R], [-H, -H], 'color', 'r', 'linewidth', 2); % coil 2
    
    if (I3 ~= 0)
        line([-R, R], [0, 0], 'color', 'r', 'linewidth', 2); % coil3
    end
   
    line([0, 0], [-1.5*H, 1.5*H], 'color', 'k'); % symmetric line
    axis equal;
    
    legend('vector field', 'coils');

    
%     % contour Bz
%     figure('color', 'white');
%     contour(MZ', 30);
%     axis equal;
%     
%     % contour Br
%     figure('color', 'white');
%     contour(MR', 30);
%     axis equal;
   
end