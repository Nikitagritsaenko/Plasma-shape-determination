% function [] = solveAndDraw(A, b0, b, I0, error_coeff, probes, currents, distortions, type)
%
% Отображает графики с информацией для главного интерактивного графика
%
% Входные данные:
% 
% A - матрица магнитных полей (A * I0 = b0)
% b0 - истинные измерения датчиков
% b - искаженные измерения датчиков
% I0 - вектор истинных значений токов
% error_coeff - значение возмущения в правой части (искажение измерений
% датчиков)
% probes - положения датчиков
% currents - положения токов
% distortions - вектор помех правой части (значения от 0 до 1). Этот вектор
% создаётся случайным образом, но он фиксирован при взаимодействии с
% системой (при изменении положений мышью)
% type - тип датчиков (R или Z)

function [] = solveAndDraw(A, b0, b, I0, error_coeff, probes, currents, distortions, type)
    rad_coeff = 0.1;
    
    n = length(b);
    m = length(I0);
    
    [I_lp, w_lp] = LP(A, b, rad_coeff);
    
    if ~isempty(w_lp)
        subplot(3, 3,1);
        hold on;
        grid on;
        title('LP_{2n} weights visualization');
        
        w = w_lp;
        ro = [];
        for i = 1:n
            shift = 0;
            if length(w) == 2 * n
                if w(i) == w(i+n)
                    shift = 0.02;
                end
                line([i, i], [w(i), w(i+n)], 'color', 'k');
                ro = plot(i+shift, w(i+n), 'o', 'MarkerEdgeColor', 'k',...
                    'MarkerFaceColor','r',...
                    'MarkerSize',8);
            end
            bo = plot(i, w(i), 'o', 'MarkerEdgeColor', 'k',...
                'MarkerFaceColor','b',...
                'MarkerSize',8);  
        end
          
        legend([bo ro], {'left bound weights' 'right bound weights'});
    end

    subplot(3, 3, [4 7]);
    I_mls = inv(A' * A) * A' * b;
    min_I0 = min(I0);
    max_I0 = max(I0);
    rad_I0 = (max_I0 - min_I0) / 2;
    ylim([min_I0 - rad_I0 max(I0) + rad_I0]);

    hold on;
    title('I vector (different solutions)');
        
    
        
%     infb = [];
%     supb = [];
%         
%     for i = 1:m
%         infb = [infb min(b * (1 - error_coeff), b * (1 + error_coeff))];
%         supb = [supb max(b * (1 - error_coeff), b * (1 + error_coeff))];
%     end
% 
%     [tolmax, I_tol] = tolsolvty(A, A, infb, supb);

    
    if ~isempty(I_lp)
        plot(1:1:m, I_lp, 'k');
    end
    
    plot(1:1:m, I_mls, 'k');
%    plot(1:1:m, I_tol, 'k');
    plot(1:1:m, I0, 'k', 'linewidth', 2);
    if ~isempty(I_lp)
        plot(1:1:m, I_lp, 'k');
    end
        
    lp_I = [];
    for i = 1:m
        real_I = plot(i, I0(i), 's', 'MarkerEdgeColor', 'k',...
            'MarkerFaceColor','b',...
            'MarkerSize',8);
        if ~isempty(I_lp)
            lp_I = plot(i, I_lp(i), 's', 'MarkerEdgeColor', 'k',...
                'MarkerFaceColor','g',...
                'MarkerSize',8);
        end
        mls_I = plot(i, I_mls(i), 's', 'MarkerEdgeColor', 'k',...
            'MarkerFaceColor','r',...
            'MarkerSize',8);
%         tol_I = plot(i, I_tol(i), 's', 'MarkerEdgeColor', 'k',...
%             'MarkerFaceColor','m',...
%             'MarkerSize',8);
    end
        
%     legend([real_I, mls_I, tol_I, lp_I], ...
%            {'real I', 'mls I', 'tol I', 'lp_{2n} I'}, ...
%            'Location', 'eastoutside');
    legend([real_I, mls_I, lp_I], ...
          {'real I', 'mls I', 'lp_{2n} I'}, ...
           'Location', 'eastoutside');
       
    subplot(3,3,2);
    
    hold on;
    grid on;
    title('b vector'); 
    
    b_real = plot(1:1:n, b0, 'b', 'linewidth', 2);
    b_distorted = plot(1:1:n, b, 'r');
    b_bound = plot(1:1:n, b0 * (1 + error_coeff), 'k--');
    b_bound = plot(1:1:n, b0 * (1 - error_coeff), 'k--');
    
    b_lp = [];
    if ~isempty(I_lp)
        b_sol = A * I_lp;
        for i = 1:n
            b_lp = plot(i, b_sol(i), 's', 'MarkerEdgeColor', 'k',...
                'MarkerFaceColor','g',...
                'MarkerSize',8);
        end
        
    end
    
    legend([b_real, b_distorted, b_bound, b_lp], ...
        {'real b vector', 'distorted b vector', 'distortion bounds', 'lp_{2n} b vector'}, ...
        'Location', 'eastoutside'); 
    
    subplot(3,3,[6 9]);
    limiter = readmatrix('data/lim.txt') / 100;
    plotTokamakSection(I_lp, probes, currents, distortions, type, error_coeff, false);
    
    X = []; Y = [];
    for i=1:m
        N = floor((I_lp(i) / 1e7) * 100);
        for j=1:N
            X = [X; currents(i, 1)];
            Y = [Y; currents(i, 2)];
        end
    end
    
    [alpha, ~, ~] = drawEllipse(X, Y);
    
    subplot(3,3,3);
    delta_lp = norm(I_lp - I0) / norm(I0);
    delta_mls = norm(I_mls - I0) / norm(I0);
    
    set(gca,'visible','off');
    text(0.5, 0.5, sprintf("distortion = %0.2f\n\\delta_{lp} = %0.2f\n\\delta_{mls} = %0.2f\n\\alpha = %0.2f", ...
        error_coeff, delta_lp, delta_mls, alpha),...
        'FontSize', 14);
    
end