clc;
clear;          
%% Init constants
R = 0.4;
r = 0.2;

r_in = R - r;
r_out = R + r;

N = 16; % num of sections

rc = r_in + (r_out - r_in) / 2;
Ic_vec = [3 3 3 3 3 9 3 3 3 3 3 3 3 3 9 3];
%Ic_vec = 3 * ones(1, N);
Ic_vec = Ic_vec * 10000000000;

grid_step = 0.01;
%% Helmhotls coil
Ih = [3 4];
Ih = Ih * 10000000000;
H = 1;
plotHelmhotz(Ih(1), Ih(2), H);
   
%% Tokamak coils (1, 2, ..., 16)
plotSectionsField(N, r_in, r_out, Ic_vec, grid_step, 'R');
plotSectionsField(N, r_in, r_out, Ic_vec, grid_step, 'Z');
%% Tokamak (view from top)
plotTopField(r_in, r_out, N, Ic_vec, grid_step, 'R');
plotTopField(r_in, r_out, N, Ic_vec, grid_step, 'Z');


