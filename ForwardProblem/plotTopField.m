function [] = plotTopField(r_in, r_out, N, Ic_vec, grid_step, mode)
    F = figure('color', 'white', 'Name', 'Tokamak (view from top)');
    set(F, 'MenuBar', 'none');
    set(F, 'ToolBar', 'none');
    
    if (mode == 'R')
        title('B_r (z = 0)');
    else
        title('B_z (z = 0)');
    end
    hold on
    
    z = 0;
    zc = 0;
    
    R = (r_out - r_in); % coil radius
    center = [r_out r_out];

    step = 0.001;
    grid_x = 0:step:r_out + center(1);
    grid_y = 0:step:r_out + center(2);
    
    MAGNETIC_B = zeros(length(grid_x), length(grid_y));
    
    N_vec = [5 4 3 2 1 16 15 14 13 12 11 10 9 8 7 6];
    I = Ic_vec;
    for i = 1:length(N_vec)
        I(i) = Ic_vec(N_vec(i));
    end
    
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)
            r = sqrt((grid_x(i) - center(1))^2 + (grid_y(j) - center(2))^2);
          
            if (r >= r_in && r <= r_out)
                phi = acos((grid_x(i) - center(1)) / r);
                
                if (grid_y(j) - center(2) < 0)
                    phi = -phi + 2*pi;
                end
                
                [MR, MZ] = calculateZeroZ(phi, N, r_in, r_out, I, grid_step);
              
                if (mode == 'R')
                    M_ZERO_Z = MR;
                else
                    M_ZERO_Z = MZ;
                end
                
                r_idx = ceil(r / grid_step);
                MAGNETIC_B(i, j) = M_ZERO_Z(r_idx);
            end
        end
    end
    MAGNETIC_B;
    
    imagesc([-r_out r_out] + center(1), [-r_out r_out] + center(2), MAGNETIC_B)
    colormap(flip(hot));
    
    if (mode == 'R')
      %caxis([-200 200]);
    else
      %caxis([-2500 0]);
    end
                
    colorbar;

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

        text(x_text, y_text, int2str(i), 'FontSize', 10, 'color', 'y')
    end
end