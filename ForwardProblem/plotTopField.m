function [] = plotTopField(MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, r_in, r_out, N, mode)
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
    coil_center = [r_in, 0];
    
    grid_step = 2*R / size(MAGNETIC_B_SECTIONS_R, 2);

    grid_x = 0:0.005:r_out + center(1);
    grid_y = 0:0.005:r_out + center(2);
    
    zero_z_idx = floor(size(MAGNETIC_B_SECTIONS_Z, 2) / 2);
    MAGNETIC_B = zeros(length(grid_x), length(grid_y));

    for i = 1:length(grid_x)
        for j = 1:length(grid_y)
            r = sqrt((grid_x(i) - center(1))^2 + (grid_y(j) - center(2))^2);

            if (r >= r_in && r <= r_out)
                phi = acos((grid_x(i) - center(1)) / r);
                [MR, MZ] = calculateSectionB(phi, MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z);
                if (mode == 'R')
                    MR_ZERO_Z = MR(:, zero_z_idx);
                else
                    MR_ZERO_Z = MZ(:, zero_z_idx);
                end
                r_idx = floor(r / grid_step);
                MAGNETIC_B(i, j) = MR_ZERO_Z(r_idx);
            end
        end
    end

    imagesc([-r_out r_out] + center(1), [-r_out r_out] + center(2), MAGNETIC_B)
    colormap([pink
        flip(hot)]);
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

        x_text = 1.04 * r_out * cos(phi) + center(1);
        y_text = 1.04 * r_out * sin(phi) + center(2);

        text(x_text, y_text, int2str(i), 'FontSize', 10)
    end
end