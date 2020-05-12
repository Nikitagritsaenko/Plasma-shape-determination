% function [Br, Bz, B] = findB(r, z, a, I)
%
% Вычисляет компоненты магнитного поля, созданного токовым кольцом с
% радиусом a и величиной тока I в точке (r, z) в системе координат данного
% кольца
%
% Br - радиальная компонента магнитного поля
% Bz - аксиальная компонента магнитного поля
% B = sqrt(Br^2+Bz^2);

function [Br, Bz, B] = findB(r, z, a, I)
    c = 299792458;
    eps = 1e-14;
    
    sign = 1;
    if (r < 0)
        fprintf('Warning: r < 0');
        sign = -1;
    end
    
    r = abs(r);
    
    k_sqr = 4 * a * r / ((a + r) ^ 2 + z^2);
    k = sqrt(k_sqr);
    
    [K, E] = ellipke(k);
    
    if (r < eps) % if (r) near 0
        disp('INFO: r near 0 \n');
        Br = 0;
        Bz = 2 * pi * a^2 * I / (c * (a^2 + z^2)^(3/2));
    else
        Br = (I / c) * 2 * z / (r * sqrt((a + r)^2 + z^2)) * (-K + E * (a^2 + r^2 + z^2) / ((a - r)^2 + z^2));
        if (abs(r-a) < eps) % if (r) near circle border
            disp('INFO: r near circle border \n');
            r = a - eps;
        end
        Bz = (I / c) * 2 / (sqrt((a + r)^2 + z^2)) * (K + E * (a^2 - r^2 - z^2) / ((a - r)^2 + z^2));
    end
   
    B = sqrt(Br^2+Bz^2);
    Br = sign * Br;
end