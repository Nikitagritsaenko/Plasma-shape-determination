clc;
clear;          
%% Init constants
R = 0.4;
r = 0.2;

r_in = R - r;
r_out = R + r;

N = 16; % num of sections

rc = r_in + (r_out - r_in) / 2;
Ic_vec = [1 1 1 1 1 10 1 1 1 1 1 1 1 1 10 1];
%Ic_vec = ones(1, N);
Ic_vec = Ic_vec * 1e7;
%% Helmhotls coil
Ih = [1 1];
Ih = Ih * 1e7;
H = 1;
R = 1;
plotHelmhotz(Ih(1), Ih(2), H, R);
   
%% Tokamak coils (1, 2, ..., 16)
grid_step = 0.005;
plotSectionsField(N, r_in, r_out, Ic_vec, grid_step, 'R');
plotSectionsField(N, r_in, r_out, Ic_vec, grid_step, 'Z');
%% Tokamak (view from top)
step = 0.01;
Br = plotTopField(r_in, r_out, N, Ic_vec, step, 'R');
Bz = plotTopField(r_in, r_out, N, Ic_vec, step, 'Z');

