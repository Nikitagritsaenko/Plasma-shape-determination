function [MR, MZ] = calculateCoilB(n, N, r_in, r_out, Ic_vec, grid_step)
    n1 = 0;
    n2 = 0;

    if (n == 1)
        n1 = N;
        n2 = 2;
        n0 = 1;
    elseif (n == N)
        n1 = N - 1;
        n2 = 1;
        n0 = N;
    else
        n0 = n;
        n1 = n0 - 1;
        n2 = n0 + 1;
    end


    R = (r_out - r_in) / 2; % coil radius

    grid_x = -R:grid_step:R;
    grid_y = -R:grid_step:R;

    MR = zeros(length(grid_y), length(grid_x));
    MZ = zeros(length(grid_y), length(grid_x));
    PROJR1 = zeros(length(grid_y), length(grid_x));
    PROJZ1 = zeros(length(grid_y), length(grid_x));
    PROJR2 = zeros(length(grid_y), length(grid_x));
    PROJZ2 = zeros(length(grid_y), length(grid_x));

    N_vec = 1:1:16;

    alpha = (2 * pi / N);
    r0 = r_in + R;
    
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)

            x = grid_x(i);
            y = grid_y(j);
            r = sqrt(x^2 + y^2);
            z = 0;
            
            if (r <= R)
                
                [Br, Bz] = findB(r, z, R, Ic_vec(N_vec(n0)));
                MR(j, i) = Br;
                MZ(j, i) = Bz;

                r1 = (r + r0) * cos(-alpha) - r0;
                z1 = (r + r0) * sin(-alpha);
                [Br, Bz] = findB(r1, z1, R, Ic_vec(N_vec(n1)));
                PROJR1(j, i) = Br;
                PROJZ1(j, i) = Bz;

                r2 = (r + r0) * cos(alpha) - r0;
                z2 = (r + r0) * sin(alpha);
                
                [Br, Bz] = findB(r2, z2, R, Ic_vec(N_vec(n2)));
                
                PROJR2(j, i) = Br;
                PROJZ2(j, i) = Bz;

            end
        end
    end

    MR = MR + PROJR1 + PROJR2;
    MZ = MZ + PROJZ1 + PROJZ2;
end