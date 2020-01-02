clc;
clear;
%% Tokamak (view from top)
F = figure('color', 'white', 'Name', 'Tokamak (view from top)');
set(F, 'MenuBar', 'none');
set(F, 'ToolBar', 'none');

hold on

r_out = 1;
r_in = 0.2 * r_out;
center = [r_out r_out];

% Plot grid
step = 0.01;
grid_x = 0:step:r_out + center(1);
grid_y = 0:step:r_out + center(2);

MAGNETIC_B = zeros(length(grid_x), length(grid_y));

z = 0;
zc = 0;
rc = r_in + (r_out - r_in) / 2;
Ic = 10000000000;

for i = 1:length(grid_x)
    for j = 1:length(grid_y)
        r = sqrt((grid_x(i) - center(1))^2 + (grid_y(j) - center(2))^2);
        if (r >= r_in && r <= r_out)
            [Br Bz B] = findB(r, z, rc, zc, Ic);
            MAGNETIC_B(i, j) = B;
        end
    end
end

imagesc([-r_out r_out] + center(1), [-r_out r_out] + center(2), MAGNETIC_B)
colormap(flip(hot));
colorbar;

% Plot circles
th = 0 : 0.01: 2 * pi;

x = r_out * cos(th) + center(1);
y = r_out * sin(th) + center(2);
plot(x, y, 'linewidth', 2, 'color', 'k');

x = r_in * cos(th) + center(1);
y = r_in * sin(th) + center(2);
plot(x, y, 'linewidth', 2, 'color', 'k');

axis equal;
axis off;

% Plot lines
N = 16; % num of sections
phi_vec = 0: (2 * pi) / N : 2 * pi;

for i = 1:N
    phi = phi_vec(i);
    
    xx = [r_in * cos(phi) + center(1) r_out * cos(phi) + center(1)];
    yy = [r_in * sin(phi) + center(2) r_out * sin(phi) + center(2)];
    
    line(xx, yy, 'color', 'k');
    
    x_text = 1.1 * r_out * cos(phi) + center(1);
    y_text = 1.1 * r_out * sin(phi) + center(2);
    
    text(x_text, y_text, int2str(i), 'FontSize', 18)
end


%% Tokamak (one of sections)
F = figure('color', 'white', 'Name', 'Tokamak (one of sections)');
set(F, 'MenuBar', 'none');
set(F, 'ToolBar', 'none');

hold on;
title('Tokamak (one of sections)');
xlabel('r, m');
ylabel('z, m');

R = (r_out - r_in); % coil radius
coil_center = [r_in, 0];

% Plot grid
step = 0.001;
grid_x = coil_center(1):step:coil_center(1)+R;
grid_y = -R+coil_center(2):step:R+coil_center(2);

MAGNETIC_B_SECTION = zeros(length(grid_x), length(grid_y));

zc = 0;
rc = r_in / 2;
Ic = 10000000000;

for i = 1:length(grid_x)
    for j = 1:length(grid_y)
       
        r = grid_x(i);
        z = grid_y(j);

        dist = sqrt((r - coil_center(1))^2 + (z - coil_center(2))^2);
        if (dist < R)
            [Br Bz B] = findB(r, z, rc, zc, Ic);
            MAGNETIC_B_SECTION(j, i) = B;
        end
    end
end

imagesc([r_in r_out + R], [-R R], MAGNETIC_B_SECTION)
colormap(flip(hot));
colorbar;


% Plot coil
th = -pi/2 : 0.01: pi/2;

x = R * cos(th) + coil_center(1);
y = R * sin(th) + coil_center(2);

hold on;
plot(x, y, 'linewidth', 2, 'color', 'k');

line([r_in r_in], [-R R], 'linewidth', 2, 'color', 'k');

axis equal;
xlim([0 r_out])
ylim([-R R])

