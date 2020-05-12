%%
clc;
clear;

m = 6;
n = 20;

[I0, probes, currents] = generate(n, m);
error_coeff = 0.1;
runInteractive(I0, probes, currents, 'R', error_coeff)
%%
[ratio_MLS_LP] = compareMLSandLP(0.1);


