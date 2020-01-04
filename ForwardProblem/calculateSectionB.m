function [MR, MZ] = calculateSectionB(phi, MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z)
    N = size(MAGNETIC_B_SECTIONS_R, 1); % number of coils
    step = (2 * pi / N);
    n1 = floor(phi / step) + 1; % nearest coil number
    n2 = n1 + 1;           % next nearest coil number
    if (n1 == 16)
        n2 = 1;
    end
    
    phi1 = n1 * step; % nearest coil angle
    phi2 = n2 * step; % next nearest coil angle
    
    % angle deltas from coils to sections
    dphi1 = phi - phi1;
    dphi2 = phi2 - phi;
    
    MR = zeros(size(MAGNETIC_B_SECTIONS_R, 2), size(MAGNETIC_B_SECTIONS_R, 3));
    MZ = zeros(size(MAGNETIC_B_SECTIONS_Z, 2), size(MAGNETIC_B_SECTIONS_Z, 3));
    
    MZ = MAGNETIC_B_SECTIONS_Z(n1, :, :) + MAGNETIC_B_SECTIONS_Z(n2, :, :);
    MR = MAGNETIC_B_SECTIONS_R(n1, :, :) * cos(dphi1) + MAGNETIC_B_SECTIONS_R(n2, :, :) * cos(dphi2);
    
    MR = squeeze(MR(1, :, :));
    MZ = squeeze(MZ(1, :, :));
end