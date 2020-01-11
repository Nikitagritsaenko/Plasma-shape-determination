function [MR, MZ] = calculateCoilB(n, N, r_in, r_out, Ic_vec, grid_step, is_zero_z)
    n1 = 0;
    n2 = 0;
    
    eps = 0.0000001;
    
    if (ceil(n) - n < eps)
        if (n == 0)
            n1 = N;
            n2 = 2;
            n0 = 1;
        elseif (n == 1)
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
    else
        phi = n;
        step = 2*pi/N;
        n2 = ceil(phi / step);
        if (n2 == 1)
            n1 = 16;
        else
            n1 = n2 - 1;
        end
    end
    
    R = (r_out - r_in) / 2; % coil radius
    grid_x = r_in:grid_step:r_out;
    grid_step_y = (2*R / (r_out - r_in)) * grid_step;
    grid_y = -R:grid_step_y:R;
    
    MR = zeros(length(grid_y), length(grid_x));
    MZ = zeros(length(grid_y), length(grid_x));
    PROJR1 = zeros(length(grid_y), length(grid_x));
    PROJZ1 = zeros(length(grid_y), length(grid_x));
    PROJR2 = zeros(length(grid_y), length(grid_x));
    PROJZ2 = zeros(length(grid_y), length(grid_x));
    
    N_vec = 1:1:16;
     
    zc = 0;
    rc = r_in + R;
    
    alpha = (2 * pi / N); 
    
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)
            
            pR = grid_x(i);
            pZ = grid_y(j);
            dist = sqrt((pR-rc)^2 + (pZ-zc)^2);
            
            if (dist < R)
                if (is_zero_z == 0 || (is_zero_z == 1 && abs(pZ) < 0.1))
                    z = 0;
                    r = pR;

                    if (ceil(n) - n < eps)
                        [Br, Bz] = findB(r, z, rc, zc, Ic_vec(N_vec(n0)));
                        MR(j, i) = Br;
                        MZ(j, i) = Bz;
                        
                        [r1, z1] = rotateVector(r, z, alpha);
                        [Br, Bz] = findB(r1, z1, rc, zc, Ic_vec(N_vec(n1)));
                        PROJR1(j, i) = Br;
                        PROJZ1(j, i) = Bz;
                    
                        [r2, z2] = rotateVector(r, z, -alpha);
                        [Br, Bz] = findB(r2, z2, rc, zc, Ic_vec(N_vec(n2)));
                        PROJR2(j, i) = Br;
                        PROJZ2(j, i) = Bz;
                    else
                        phi1 = step * (n1 - 1);
                        phi2 = step * (n2 - 1);
                        
                        [r1, z1] = rotateVector(r, z, phi1 - phi);
                        [Br, Bz] = findB(r1, z1, rc, zc, Ic_vec(N_vec(n1)));
                        PROJR1(j, i) = Br;
                        PROJZ1(j, i) = Bz;
                    
                        [r2, z2] = rotateVector(r, z, phi - phi2);
                        [Br, Bz] = findB(r2, z2, rc, zc, Ic_vec(N_vec(n2)));
                        PROJR2(j, i) = Br;
                        PROJZ2(j, i) = Bz; 
                    end
                    
                    
                end      
            end
        end
    end
    
    MR = MR + PROJR1 + PROJR2;
    MZ = MZ + PROJZ1 + PROJZ2;
end