clc;
clear;
%% Init constants
r_out = 1;
r_in = 0.2 * r_out;
center = [r_out r_out];

N = 16; % num of sections

rc = r_in + (r_out - r_in) / 2;
Ic_vec = [3 3 3 3 3 9 3 3 3 3 3 3 3 3 9 3];
%Ic_vec = 3 * ones(1, N);
Ic_vec = Ic_vec * 10000000000;

[MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, MAGNETIC_B_SECTIONS] = getSectionsField(N, r_in, r_out, Ic_vec);
%% Tokamak coils (1, 2, ..., 16)
plotSectionsField(MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, r_in, r_out, 'R');
plotSectionsField(MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, r_in, r_out, 'Z');
%% Tokamak (view from top)
plotTopField(MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, r_in, r_out, N, 'R');
%plotTopField(MAGNETIC_B_SECTIONS_R, MAGNETIC_B_SECTIONS_Z, r_in, r_out, N, 'Z');

