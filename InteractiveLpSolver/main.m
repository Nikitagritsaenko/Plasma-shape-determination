%% ÇÀÏÓÑÊ ÍÀ ĞÅÀËÜÍÛÕ ÄÀÍÍÛÕ
clc;
clear;

m = 19;

real_data = true;
[I0, probes, currents] = generate(0, m, real_data);
error_coeff = 0.1;

figure('units','normalized','outerposition',[0 0 1 1],'color','white');

for time_idx = 1:105 % ìîæíî äî 105
    runInteractive(I0, probes, currents, 'R', error_coeff, real_data, time_idx);
    pause(0.1);
end
%% ÇÀÏÓÑÊ ÍÀ ÍÀØÈÕ ÄÀÍÍÛÕ
clc;
clear;

m = 6;
n = 20;

[I0, probes, currents] = generate(n, m, false);
error_coeff = 0.1;
figure('units','normalized','outerposition',[0 0 1 1],'color','white');
runInteractive(I0, probes, currents, 'R', error_coeff, false, 0)
%% ÒÅÑÒÈĞÓÅÌ MLS vs LP (ÍÀ ÍÀØÈÕ ÄÀÍÍÛÕ)
clc;
clear;
[ratio_MLS_LP] = compareMLSandLP(0.1);


