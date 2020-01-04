function [MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, MAGNETIC_B_SECTIONS] = getSectionsField(N, r_in, r_out, Ic_vec)
    R = (r_out - r_in); % coil radius
    coil_center = [r_in, 0];

    grid_step = 0.01;
    grid_x = coil_center(1):grid_step:coil_center(1)+R;
    grid_y = -R+coil_center(2):grid_step:R+coil_center(2);


    MAGNETIC_B_SECTIONS_R = zeros(N, length(grid_x), length(grid_y));
    MAGNETIC_B_SECTIONS_Z = zeros(N, length(grid_x), length(grid_y));
    MAGNETIC_B_SECTIONS = zeros(N, length(grid_x), length(grid_y));

    zc = 0;
    rc = r_in / 2;
    
    for n = 1:N
        for i = 1:length(grid_x)
            for j = 1:length(grid_y)

                r = grid_x(i);
                z = grid_y(j);

                dist = sqrt((r - coil_center(1))^2 + (z - coil_center(2))^2);
                if (dist < R)
                    [Br, Bz, B] = findB(r, z, rc, zc, Ic_vec(n));
                    MAGNETIC_B_SECTIONS_R(n, j, i) = Br;
                    MAGNETIC_B_SECTIONS_Z(n, j, i) = Bz;
                    MAGNETIC_B_SECTIONS(n, j, i) = B;
                end
            end
        end
    end
    
end