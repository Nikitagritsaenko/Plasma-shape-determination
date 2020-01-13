function [MR, MZ] = calculateZeroZ(phi, N, r_in, r_out, Ic_vec, grid_step)
    n1 = 0;
    n2 = 0;

    step = 2*pi/N;
    n2 = ceil(phi / step);
    
    if (n2 == 0)
        n2 = 1;
        n1 = 16;
    elseif (n2 == 1)
        n1 = 16;
    else
        n1 = n2 - 1;
    end

    R = (r_out - r_in) / 2; % coil radius
    grid_x = -R:grid_step:R;

    MR = zeros(length(grid_x));
    MZ = zeros(length(grid_x));
    
    PROJR1 = zeros(length(grid_x));
    PROJZ1 = zeros(length(grid_x));
    PROJR2 = zeros(length(grid_x));
    PROJZ2 = zeros(length(grid_x));

    N_vec = 1:1:16;


    for i = 1:length(grid_x)
        r = grid_x(i);
        z = 0;
        if (r < R)
            phi1 = step * (n1 - 1);
            phi2 = step * (n2 - 1);
            
            [r1, z1] = rotateVector(abs(r), z, phi1 - phi);
            [Br, Bz] = findB(abs(r1), z1, R, Ic_vec(N_vec(n1)));
            PROJR1(i) = Br;
            PROJZ1(i) = Bz;
            
            [r2, z2] = rotateVector(r, z, phi - phi2);
            [Br, Bz] = findB(abs(r2), z2, R, Ic_vec(N_vec(n2)));
            PROJR2(i) = Br;
            PROJZ2(i) = Bz;  
        end
    end

    MR = MR + PROJR1 + PROJR2;
    MZ = MZ + PROJZ1 + PROJZ2;
end