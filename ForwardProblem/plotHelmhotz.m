function [] = plotHelmhotz(I1, I2, H, R)    
    
    % 1. Plot in RZ plane
    grid_step_x = 0.1;
    grid_x = -R:grid_step_x:R;
    grid_step_y = 4 * H / (2 * R) * grid_step_x;
    grid_y = -2*H:grid_step_y:2*H;
    
    MR = zeros(length(grid_y), length(grid_x));
    MZ = zeros(length(grid_y), length(grid_x));
    MZR = zeros(length(grid_y), length(grid_x));
      
    psi = atan(2 * R / H);
    S = sqrt(R^2 + H^2/4);
    
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)  
            r = abs(grid_x(i));
            z = grid_y(j);    

            [Br1, Bz1, B1] = findB(r, z - H/2, R, I1);
            [Br2, Bz2, B2] = findB(r, z + H/2, R, I2);

            %[Br1, Bz1] = findBpsi(r, z, psi, S, I1);
            %[Br2, Bz2] = findBpsi(r, z, psi, S, I2);
            
            MR(j, i) = Br1 + Br2;
            MZ(j, i) = Bz1 + Bz2;
            MZR(j, i) = B1 + B2;
        end
    end

%     nlines = 200;
%     figure('color', 'white');
%     %imagesc([-R, R], [-2*H, 2*H], MR);
%     set(gca,'YDir','normal');
%     contour(MR, nlines);
%     axis equal;
%     title("B_r Helmhotlz");
%     xlabel('r, m');
%     ylabel('z, m');
%     colormap((hot));
%     colorbar;
% 
%     figure('color', 'white');
%     %imagesc([-R, R], [-2*H, 2*H], MZ);
%     set(gca,'YDir','normal');
%     contour(MZ, nlines);
%     axis equal;
%     title("B_z Helmhotlz");
%     xlabel('r, m');
%     ylabel('z, m');
%     colormap((hot));
%     colorbar;
%     
%     figure('color', 'white');
%     %imagesc([-R, R], [-2*H, 2*H], MZ);
%     set(gca,'YDir','normal');
%     contour(MZR, nlines);
%     axis equal;
%     title("B Helmhotlz");
%     xlabel('r, m');
%     ylabel('z, m');
%     colormap((hot));
%     colorbar;
    
    figure('color', 'white');
    quiver(squeeze(MR), squeeze(MZ));
    colorbar;
    axis equal;

end