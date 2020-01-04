function [] = plotSectionsField(MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, r_in, r_out, mode)
    R = (r_out - r_in); % coil radius
    coil_center = [r_in, 0];

    N = size(MAGNETIC_B_SECTIONS_R, 1); % number of coils
    F = figure('color', 'white', 'Name', 'Tokamak sections');
    set(F, 'MenuBar', 'none');
    set(F, 'ToolBar', 'none');

    for n = 1:1:N
        subplot(sqrt(N), sqrt(N), n);

        colormap([pink
            flip(hot)]);

        [MR, MZ] = calculateCoilB(n, MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z);
        MR = squeeze(MR(1, :, :));
        MZ = squeeze(MZ(1, :, :));
        
        if (mode == 'R')
            imagesc([r_in r_out + R], [-R R], MR);
            title("B_r n = " + n);
            caxis([-100 100]);
        else
            imagesc([r_in r_out + R], [-R R], MZ);
            title("B_z n = " + n);
            caxis([-400 0]);
        end
         
        xlabel('r, m');
        ylabel('z, m');
        
        colorbar;

        % Plot coil contour
        th = -pi/2 : 0.01: pi/2;

        x = R * cos(th) + coil_center(1);
        y = R * sin(th) + coil_center(2);

        hold on;
        plot(x, y, 'linewidth', 2, 'color', 'k');
        line([r_in r_in], [-R R], 'linewidth', 2, 'color', 'k');


        axis equal;
        xlim([0 r_out])
        ylim([-R R])
    end

end