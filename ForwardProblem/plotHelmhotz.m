function [] = plotHelmhotz(I1, I2, H)    
    D = 1;
    R = D / 2;
    
    % 1. Plot in RZ plane
    grid_step_x = 0.01;
    grid_x = 0:grid_step_x:D;
    grid_step_y = H / D * grid_step_x;
    grid_y = 0:grid_step_y:H;
    
    MR = zeros(length(grid_y), length(grid_x));
    MZ = zeros(length(grid_y), length(grid_x));
      
    % coord of coil center in local r-z axis 
    rc = R;
    zc = 0;
    
    for i = 1:length(grid_x)
        for j = 1:length(grid_y)  
            r = grid_x(i);
            z = grid_y(j);    

            [Br1, Bz1] = findB(r, H/2 - z, rc, zc, I1);
            [Br2, Bz2] = findB(r, z - H/2, rc, zc, I2);
            
            MR(j, i) = Br1 + Br2;
            MZ(j, i) = Bz1 + Bz2;
        end
    end

    nlines = 45;
    figure('color', 'white');
    imagesc([0, D], [0, H], MR);
    set(gca,'YDir','normal');
    contour(MR, nlines);
    title("B_r Helmhotlz");
    xlabel('r, m');
    ylabel('z, m');
    colormap(flip(hot));
    colorbar;

    figure('color', 'white');
    imagesc([0, D], [0, H], MZ);
    set(gca,'YDir','normal');
    contour(MZ, nlines)
    title("B_z Helmhotlz");
    xlabel('r, m');
    ylabel('z, m');
    colormap(flip(hot));
    colorbar;
    
%     hold on;
%     line([0 D], [H H], 'color', 'g', 'linewidth', 3);
%     
%     hold on;
%     line([0 D], [0 0], 'color', 'g', 'linewidth', 3);
    
    % 2. Plot in coil 1 and coil 2 plane
%     
%     grid_step_x = 0.01;
%     grid_x = 0:grid_step_x:D;
%     grid_step_y = 2*R / D * grid_step_x;
%     grid_y = -R:grid_step_y:R;
%     
%     MR1 = zeros(length(grid_y), length(grid_x));
%     MZ1 = zeros(length(grid_y), length(grid_x));
%     MR2 = zeros(length(grid_y), length(grid_x));
%     MZ2 = zeros(length(grid_y), length(grid_x));
%     
%     % coord of coil center in local r-z axis 
%     rc = R;
%     zc = 0;
%     
%     for i = 1:length(grid_x)
%         for j = 1:length(grid_y)  
%             x = grid_x(i);
%             y = grid_y(j);    
%             
%             r = x;
%             % field coil 1 produced to point of coil 1
%             [Br11, Bz11] = findB(r, zc, rc, zc, I1);
%             
%             % field coil 2 produced to point of coil 1
%             [Br21, Bz21] = findB(r, -H, rc, zc, I2);
%             
%             % field coil 2 produced to point of coil 2
%             [Br22, Bz22] = findB(r, zc, rc, zc, I2);
%             
%             % field coil 1 produced to point of coil 2
%             [Br12, Bz12] = findB(r, H, rc, zc, I1);
%             
%             MR1(j, i) = Br11 + Br21;
%             MZ1(j, i) = Bz11 + Bz21;
%             
%             MR2(j, i) = Br12 + Br22;
%             MZ2(j, i) = Bz12 + Bz22;
%             
%         end
%     end
% 
%     figure('color', 'white');
%     subplot(2,2,1);
%     contour(MR1, nlines)
%     title("B_r Helmhotlz coil 1");
%     xlabel('r, m');
%     ylabel('z, m');
%     colormap(flip(hot));
%     colorbar;
% 
%     subplot(2,2,2);
%     contour(MZ1, nlines)
%     title("B_z Helmhotlz coil 1");
%     xlabel('r, m');
%     ylabel('z, m');
%     colormap(flip(hot));
%     colorbar;
%     
%     subplot(2,2,3);
%     contour(MR2, nlines)
%     title("B_r Helmhotlz coil 2");
%     xlabel('r, m');
%     ylabel('z, m');
%     colormap(flip(hot));
%     colorbar;
% 
%     subplot(2,2,4);
%     contour(MZ1, nlines)
%     title("B_z Helmhotlz coil 2");
%     xlabel('r, m');
%     ylabel('z, m');
%     colormap(flip(hot));
%     colorbar;

end