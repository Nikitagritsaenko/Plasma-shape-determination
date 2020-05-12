% function update(varargin)
%
% Обновляет информацию на интерактивном графике в соответствии с новыми
% положениями токов и датчиков
%
% Входные данные:
% 
% I - вектор токов
% probes - положения датчиков
% currents - положения токов
% distortions - вектор помех правой части (значения от 0 до 1). Этот вектор
% создаётся случайным образом, но он фиксирован при взаимодействии с
% системой (при изменении положений мышью)
% type - тип датчиков (R или Z)
% error_coeff - значение возмущения в правой части

function update(varargin)
    
    I = varargin{1};
    probes = varargin{2};
    currents = varargin{3};
    distortions = varargin{4};
    type = varargin{5};
    error_coeff = varargin{6};
    
    cla(subplot(3, 3, [5 8]));
    subplot(3, 3, [5 8]);

    plotTokamakSection(I, probes, currents, distortions, type, error_coeff, true);

    cla(subplot(3, 3, [4, 7]));
    cla(subplot(3, 3, [6, 9]));
    cla(subplot(3, 3, 1));
    cla(subplot(3, 3, 2));
    cla(subplot(3, 3, 3));
    [Ar, Az] = findField(I, probes, currents);
    if type == 'R'
        A = Ar;
    else
        A = Az;
    end
    b0 = A * I;
    b = distortVector(b0, error_coeff, distortions);
    
    solveAndDraw(A, b0, b, I, error_coeff, probes, currents, distortions, type)
end