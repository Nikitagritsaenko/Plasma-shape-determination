function [MAGNETIC_B] = plotTopField(r_in, r_out, N, Ic_vec, step, mode)
    F = figure('color', 'white', 'Name', 'Tokamak (view from top)');
    
    if (mode == 'R')
        title('B_r (z = 0)');
    elseif (mode == 'Z')
        title('B_z (z = 0)');
    else
        title('B (z = 0)');
    end
    hold on;
    
    R = (r_out - r_in) / 2; % coil radius

    grid_x = -r_out:step:r_out;
    grid_y = -r_out:step:r_out;
    
    MAGNETIC_B = zeros(length(grid_x), length(grid_y));
    MAGNETIC_BR = zeros(length(grid_x), length(grid_y));
    MAGNETIC_BZ = zeros(length(grid_x), length(grid_y));
    
    N_vec = [5 4 3 2 1 16 15 14 13 12 11 10 9 8 7 6];
    I = Ic_vec;
    for i = 1:length(N_vec)
        I(i) = Ic_vec(N_vec(i));
    end
    
    r0 = r_in + R;
    angle_step = 2*pi / N;
    
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)
            r = sqrt((grid_x(i))^2 + (grid_y(j))^2);
          
            if (r >= r_in && r <= r_out)
                phi = acos((grid_x(i)) / r);
                
                if (grid_y(j) < 0)
                    phi = -phi + 2*pi;
                end
                
                n2 = ceil(phi / angle_step) + 1;
                n1 = floor(phi / angle_step) + 1;
                if (n1 == 16)
                  n2 = 1;  
                end
                
                phi1 = angle_step * (n1 - 1);
                phi2 = angle_step * (n2 - 1);
                
                dphi1 = phi1 - phi;
                r1 = r * cos(dphi1) - r0;
                z1 = abs(r * sin(dphi1));
                
               
                [Br1, Bz1] = findB(r1, z1, R, Ic_vec(N_vec(n1)));

                dphi2 = phi2 - phi;
                r2 = r * cos(dphi2) - r0;
                z2 = -abs(r * sin(dphi2));
                
                [Br2, Bz2] = findB(r2, z2, R, Ic_vec(N_vec(n2)));
                
                MAGNETIC_BR(i, j) = Br1 + Br2;
                MAGNETIC_BZ(i, j) = Bz1 + Bz2;
                
                if (mode == 'R')
                    MAGNETIC_B(i, j) = Br1 + Br2;
                elseif (mode == 'Z')
                    MAGNETIC_B(i, j) = Bz1 + Bz2;
                else
                    MAGNETIC_B(i, j) = sqrt((Br1 + Br2)^2 + (Bz1 + Bz2)^2);
                end
            end
        end
    end
    
    % Plot field
    center = [r_out r_out];
    
    size(grid_x)
    size(grid_y)
    size(MAGNETIC_BR')
    size(MAGNETIC_BZ')
    
    if (mode == 'R' || mode == 'Z')
        imagesc([-r_out r_out] + center(1), [-r_out r_out] + center(2), MAGNETIC_B)
        colormap(flip(hot));
        colorbar;
    else
        quiver(grid_x + center(1), grid_y + center(2), MAGNETIC_BR', MAGNETIC_BZ');
    end
    
    if (mode == 'R')
        caxis([-15, 15]);
    else
        caxis([0, 15]);
    end
    
    % Plot circles
    th = 0 : 0.01: 2 * pi;
    x = r_out * cos(th) + center(1);
    y = r_out * sin(th) + center(2);
    plot(x, y, 'linewidth', 2, 'color', 'k'); hold on;
    x = r_in * cos(th) + center(1);
    y = r_in * sin(th) + center(2);
    plot(x, y, 'linewidth', 2, 'color', 'k');
    axis equal;
    axis off;
    phi_vec = 0:2*pi/N:2*pi;

    % Plot lines
    for i = 1:N
        phi = phi_vec(i);
        xx = [r_in * cos(phi) + center(1) r_out * cos(phi) + center(1)];
        yy = [r_in * sin(phi) + center(2) r_out * sin(phi) + center(2)];
        line(xx, yy, 'color', 'k');
        x_text = 1.05 * r_out * cos(phi) + center(1);
        y_text = 1.05 * r_out * sin(phi) + center(2);
        text(x_text, y_text, int2str(i), 'FontSize', 10, 'color', 'k')
    end

end