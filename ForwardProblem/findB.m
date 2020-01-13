function [Br, Bz] = findB(r, z, a, I)
    c = 299792458;
    eps = a / 1e2;
    
    k_sqr = 4 * a * r / ((a + r) ^ 2 + z^2);
    k = sqrt(k_sqr);
    
    [K, E] = ellipke(k);
    
    if (r == 0)
        Br = 0;
        Bz = 2 * pi * a^2 * I / (c * (a^2 + z^2)^(3/2));
    else
        Br = (I / c) * 2 * z / (r * sqrt((a + r)^2 + z^2)) * (-K + E * (a^2 + r^2 + z^2) / ((a - r)^2 + z^2));
        Bz = (I / c) * 2 / (sqrt((a + r)^2 + z^2)) * (K + E * (a^2 - r^2 - z^2) / ((a - r)^2 + z^2));
    end
end