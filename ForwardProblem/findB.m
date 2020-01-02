function [Br, Bz, B] = findB(r, z, rc, zc, Ic)
    c = 299792458;
    k_sqr = 4 * rc * r / ((rc + r) ^ 2 + (zc - z)^2);
    k = sqrt(k_sqr);
    
    [K, E] = ellipke(k);
    
    Br = (Ic / c) * ((zc - z) / r) * 2 * k * sqrt(rc * r) * ((1 - k_sqr / 2) * E - K);
    Bz = (Ic / c) * 2 * k * sqrt(rc * r) * ((r - rc) / r * (1 - k_sqr / 2) * E - K);
    B = sqrt(Br^2 + Bz^2);   
end