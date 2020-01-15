function [] = plotSectionsField(N, r_in, r_out, Ic_vec, grid_step, mode)
    R = (r_out - r_in) / 2; % coil radius
    coil_center = [r_in + R, 0];

    F = figure('color', 'white', 'Name', 'Tokamak sections');
    set(F, 'MenuBar', 'none');
    set(F, 'ToolBar', 'none');

    for n = 1:1:N
        subplot(sqrt(N), sqrt(N), n);

        colormap(flip(hot));

        [MR, MZ] = calculateCoilB(n, N, r_in, r_out, Ic_vec, grid_step);
       
        if (mode == 'R')
            imagesc([r_in, r_out], [-R, R], MR);
            title("B_R n = " + n);
            set(gca,'YDir','normal')
            %caxis([-200 200]);
        else
            imagesc([r_in, r_out], [-R, R], MZ);
            title("B_Z n = " + n);
            set(gca,'YDir','normal')
            caxis([0 100]);
        end
        
        hold on;
        xlabel('R, m');
        ylabel('Z, m');
        
        colorbar;

        % Plot coil contour
        th = 0 : 0.01: 2*pi;

        x = R * cos(th) + coil_center(1);
        y = R * sin(th) + coil_center(2);
        
        plot(x, y, 'color', 'k', 'linewidth', 1);

        axis equal;
        xlim([0 r_out]);
        ylim([-R R]);
    end

end