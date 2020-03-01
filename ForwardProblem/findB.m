function [Br, Bz, B] = findB(r, z, a, I)
    c = 299792458;
    eps = 1e-14;
    
    sign = 1;
    if (r < 0)
        sign = -1;
    end
    
    r = abs(r);
    
    k_sqr = 4 * a * r / ((a + r) ^ 2 + z^2);
    k = sqrt(k_sqr);
    
    [K, E] = ellipke(k);
    
    if (r < eps) % if (r) near 0
        Br = 0;
        Bz = 2 * pi * a^2 * I / (c * (a^2 + z^2)^(3/2));
    else
        Br = (I / c) * 2 * z / (r * sqrt((a + r)^2 + z^2)) * (-K + E * (a^2 + r^2 + z^2) / ((a - r)^2 + z^2));
        if (abs(r-a) < eps) % if (r) near circle border
            delta = 0.01;
            r = a - delta;
        end
        Bz = (I / c) * 2 / (sqrt((a + r)^2 + z^2)) * (K + E * (a^2 - r^2 - z^2) / ((a - r)^2 + z^2));
    end
   
    B = sqrt(Br^2+Bz^2);
    Br = sign * Br;
end