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
% real_data - флажок, будем ли читать данные из файла вместо генерации
% time_idx - индекс времени, по которому берем показания датчиков

function [] = runInteractive(I, probes, currents, type, error_coeff, real_data, time_idx)    
    n = size(probes, 1);
    m = size(currents, 1);
    
    % искажения делаем постоянными для любого эксперимента
    distortions = zeros(n, 1);
    for j = 1:n
        distortions(j) = rand();
    end
    
    update(I, probes, currents, distortions, type, error_coeff, real_data, time_idx);

end