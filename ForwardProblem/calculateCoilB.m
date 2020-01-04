function [MR, MZ] = calculateCoilB(n, MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z)
    N = size(MAGNETIC_B_SECTIONS_R, 1); % number of coils
    MR = zeros(size(MAGNETIC_B_SECTIONS_R, 2), size(MAGNETIC_B_SECTIONS_R, 3));
    MZ = zeros(size(MAGNETIC_B_SECTIONS_Z, 2), size(MAGNETIC_B_SECTIONS_Z, 3));
    
    if (n == 1)
        MZ = MAGNETIC_B_SECTIONS_Z(1, :, :) + MAGNETIC_B_SECTIONS_Z(2, :, :) + MAGNETIC_B_SECTIONS_Z(N, :, :);
        MR = MAGNETIC_B_SECTIONS_R(n, :, :) + (MAGNETIC_B_SECTIONS_R(N, :, :) + MAGNETIC_B_SECTIONS_R(n+1, :, :)) * cos(2 * pi / N);
    elseif (n == N)
        MZ = MAGNETIC_B_SECTIONS_Z(N, :, :) + MAGNETIC_B_SECTIONS_Z(N-1, :, :) + MAGNETIC_B_SECTIONS_Z(1, :, :);
        MR = MAGNETIC_B_SECTIONS_R(N, :, :) + (MAGNETIC_B_SECTIONS_R(N-1, :, :) + MAGNETIC_B_SECTIONS_R(1, :, :)) * cos(2 * pi / N);
    else
        MZ = MAGNETIC_B_SECTIONS_Z(n, :, :) + MAGNETIC_B_SECTIONS_Z(n-1, :, :) + MAGNETIC_B_SECTIONS_Z(n+1, :, :);
        MR = MAGNETIC_B_SECTIONS_R(n, :, :) + (MAGNETIC_B_SECTIONS_R(n-1, :, :) + MAGNETIC_B_SECTIONS_R(n+1, :, :)) * cos(2 * pi / N);
    end
    
    %MR = squeeze(MR(1, :, :));
    %MZ = squeeze(MZ(1, :, :));
end