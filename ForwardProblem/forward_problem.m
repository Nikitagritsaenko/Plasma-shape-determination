clc;
clear;  
%% Init constants
r0 = 0.4; % r_in + R
r = 0.2;

r_in = r0 - r;
r_out = r0 + r;

N = 16; % num of sections

rc = r_in + (r_out - r_in) / 2;
Ic_vec = [1 1 1 1 1 10 1 1 1 1 1 1 1 1 10 1];
Ic_vec = ones(1, N);
Ic_vec = Ic_vec * 1e7;
%% One current coil
I = 1e7;
H = 1;
R = 1;
plotHelmhotz(0, 0, I, H, R);

%% Helmhotls coil
Ih = [1 1 1];
Ih = Ih * 1e7;
D = 2;
R = 1;
plotHelmhotz(Ih(1), Ih(2), Ih(3), D, R);
   
%% Tokamak coils (1, 2, ..., 16)
grid_step = 0.005;
plotSectionsField(N, r_in, r_out, Ic_vec, grid_step, 'R');
plotSectionsField(N, r_in, r_out, Ic_vec, grid_step, 'Z');
%% Tokamak three coils: 1, 2, 16:
Ih = [1 1 1];
Ih = Ih * 1e7;
r_in = 0.2;
R = 0.2;
plotThreeCoils(Ih(1), Ih(2), Ih(3), r_in, R)   
%% Tokamak (view from top)
step = 0.0025;
%Br = plotTopField(r_in, r_out, N, Ic_vec, step, 'R');
%Bz = plotTopField(r_in, r_out, N, Ic_vec, step, 'Z');
plotTopField(r_in, r_out, N, Ic_vec, step, 'Q');

