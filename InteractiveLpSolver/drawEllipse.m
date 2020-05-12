% function [alpha, a, b] = drawEllipse(X, Y)
%
% Рисует эллипс рассеяния вокруг точек (X, Y)
%
% Выходные данные
%
% alpha - угол наклона эллипса (рад)
% a, b - размер полуосей эллипса
function [alpha, a, b] = drawEllipse(X, Y)
    K = corr(X, Y); % коэфф. корреляции Пирсона
    sigma_x = sqrt(var(X));
    sigma_y = sqrt(var(Y));
    
    alpha = atan(2 * K  * sigma_x * sigma_y / (sigma_x ^ 2 - sigma_y ^ 2)) / 2;
    
    sigma_psi = sqrt(sigma_x ^ 2 * cos(alpha) ^ 2 + K * sigma_x * sigma_y * sin(2 * alpha) + sigma_y ^ 2 * sin(alpha) ^ 2);
    sigma_phi = sqrt(sigma_x ^ 2 * sin(alpha) ^ 2 - K * sigma_x * sigma_y * sin(2 * alpha) + sigma_y ^ 2 * cos(alpha) ^ 2);
    h_psi = 1 / (sigma_psi * sqrt(2));
    h_phi = 1 / (sigma_phi * sqrt(2));
    R_psi = sqrt(3) / h_psi;
    R_phi = sqrt(3) / h_phi;
    
    a = R_psi;
    b = R_phi;
    
    ellipse_1 = @(y)(a*sqrt(1-y*y/(b*b)));
    ellipse_2 = @(y)(-a*sqrt(1-y*y/(b*b)));
    
    R = [cos(alpha) -sin(alpha); 
         sin(alpha) cos(alpha)];
    C = [mean(X)
         mean(Y)];
    y = -b:0.00001:b;
    
    points = [];
    for i = 1:length(y)
        p1 = [ellipse_1(y(i)) y(i)];
        p2 = [ellipse_2(y(i)) y(i)];
        points = [points, R * p1' + C, R * p2' + C];
    end
    
    
    plot(points(1, :), points(2, :), 'ko', 'MarkerSize', 2, 'MarkerFaceColor', 'k');
    plot(X, Y, 'go', 'MarkerSize', 8, 'MarkerFaceColor', 'g');
    
    % построение осей
    x = -a:0.00001:a;
    ax1 = [];
    for i = 1:length(x)
        p = [x(i) 0];
        ax1 = [ax1, R * p' + C];
    end
    plot(ax1(1, :), ax1(2, :), 'k-');
    
    ax2 = [];
    for i = 1:length(y)
        p = [0 y(i)];
        ax2 = [ax2, R * p' + C];
    end
    plot(ax2(1, :), ax2(2, :), 'k-');
    
    % построение центра
    plot(C(1), C(2), 'rx', 'MarkerSize', 10, 'LineWidth', 1.5);
    
end