% function [] = runInteractive(I, probes, currents, type, error_coeff)  
%
% Запускает интерактивный график, с помощью которого можно менять положения
% токов и датчиков и смотреть, как меняется решение ЗЛП и МНК
%
% Входные данные:
% 
% I - вектор токов
% probes - положения датчиков
% currents - положения токов
% type - тип датчиков (R или Z)
% error_coeff - значение возмущения в правой части

function [] = runInteractive(I, probes, currents, type, error_coeff)    
    f = figure('units','normalized','outerposition',[0 0 1 1],'color','white');
    
    n = size(probes, 1);
    m = size(currents, 1);
    
    % искажения делаем постоянными для любого эксперимента
    distortions = zeros(n, 1);
    for j = 1:n
        distortions(j) = rand();
    end
    
    update(I, probes, currents, distortions, type, error_coeff);

end