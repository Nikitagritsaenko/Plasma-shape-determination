% function [] = plotTokamakSection(I, probes, currents, distortions, type, error_coeff, interactive, real_data, time_idx)
%
% Рисует сечение токамака: лимитер, столб токамака, датчики и токи. Также
% выводятся значения токов. 
%
% При флаге interactive = true можно взаимодейстовать с системой, 
% меняя мышью положения токов и датчиков. В этом случае задача поиска вектора токов
% решается с новыми положениями токов и датчиков, а все вспомогательные
% графики перестраиваются.
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
% interactive - флаг интерактивного взаимодействия
% real_data - флажок, будем ли читать данные из файла вместо генерации
% time_idx - индекс времени, по которому берем показания датчиков

function [] = plotTokamakSection(I, probes, currents, distortions, type, error_coeff, interactive, real_data, time_idx)
    global dpt;
    
    n = size(probes, 1);
    m = size(currents, 1);
    % считываем данные лимитера (конвертируем [см] в [м])
    limiter = readmatrix('data/lim.txt') / 100;
    s = size(limiter, 1);
    r_in = 0.125;

    % рисуем лимитер
    plot(limiter(:, 1), limiter(:, 2), 'k');
    line([limiter(1, 1), limiter(s, 1)], ...
        [limiter(1, 2), limiter(s, 2)], 'color', 'k');

    % рисуем датчики и токи с нумерацией
    title(sprintf('Currents and probes \n(m = %i, n = %i)', m, n));
    xlim([-1,1]);
    ylim([-1,1]);
    hold on;

    for i = 1:size(currents, 1)
        if (I(i) > 0)
            h(i) = plot(currents(i, 1), currents(i, 2), 'o', ...
                'MarkerEdgeColor', 'k',...
                'MarkerFaceColor','r',...
                'MarkerSize',10);
            if interactive
                set(h(i),'UserData',n+i)
                draggable(h(i), 'endfcn', @updateCurrent);
            end
            text(currents(i, 1) + 0.04, currents(i, 2) + 0.04, sprintf('%i', i), 'FontSize', 8)
            text(-0.5, 1 - i * 0.1, ...
                sprintf('I_{%i} = %.2f', i, I(i) / 1e6), 'FontSize', 12)
        end
       
    end

    for i = 1:size(probes, 1)
        h(i) = plot(probes(i, 1), probes(i, 2), 's', ...
            'MarkerEdgeColor', 'k',...
            'MarkerFaceColor','b',...
            'MarkerSize',10);
        if interactive
            set(h(i),'UserData', i)
            draggable(h(i), 'endfcn', @updateProbe);
        end

        text(probes(i, 1) + 0.04, probes(i, 2) + 0.04, int2str(i), 'FontSize', 8)
    end
    hold on;

    % рисуем границы столба
    y_min = min(probes(:,2));
    y_max = max(probes(:,2));
    x_min = min(probes(:,1));
    x_max = max(probes(:,1));

    line([0 0], 2*[y_min y_max], 'color', 'k');
    line(0.95*[r_in r_in], 2*[y_min y_max], 'color', 'k');
    axis equal;
    
    % callback функции
    function updateProbe(varargin)
        idx = get(varargin{1,1}, 'UserData');
        probes(idx, :) = probes(idx, :) + dpt;
        update(I, probes, currents, distortions, type, error_coeff, real_data, time_idx);
    end

    function updateCurrent(varargin)
        idx = get(varargin{1,1}, 'UserData');
        currents(idx - n, :) = currents(idx - n, :) + dpt;
        update(I, probes, currents, distortions, type, error_coeff, real_data, time_idx);
    end

end