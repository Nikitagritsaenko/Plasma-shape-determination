function [] = plotHelmhotz(MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, r_in, r_out)
    MR = zeros(size(MAGNETIC_B_SECTIONS_R, 2), size(MAGNETIC_B_SECTIONS_R, 3));
    MZ = zeros(size(MAGNETIC_B_SECTIONS_Z, 2), size(MAGNETIC_B_SECTIONS_Z, 3));

    MZ = MAGNETIC_B_SECTIONS_Z(1, :, :) + MAGNETIC_B_SECTIONS_Z(2, :, :);
    MR = MAGNETIC_B_SECTIONS_R(1, :, :) + MAGNETIC_B_SECTIONS_R(2, :, :);

    MR = squeeze(MR(1, :, :));
    MZ = squeeze(MZ(1, :, :));

    R = (r_out - r_in);

    figure('color', 'white');
    contour(MR, 15)
    %imagesc([0 R], [-R R], MR);
    title("B_r Helmhotlz");
    xlabel('r, m');
    ylabel('z, m');
    colormap(hot);
    colorbar;

    figure('color', 'white');
    contour(MZ, 15)
    %imagesc([0 R], [-R R], MZ);
    title("B_z Helmhotlz");
    xlabel('r, m');
    ylabel('z, m');
    colormap(hot);
    colorbar;
end