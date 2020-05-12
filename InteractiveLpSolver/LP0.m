% [I, w] = LP0(A, b, rad_coeff)
% Решает систему AI = b с помощью поставленной задачи линейного
% программирования
%
% A - матрица (n x m)
% b - вектор правой части (n x 1)
% rad_coeff - коэффициент для радиусов правой части: rad{b_i} = rad_coeff * b_i
% 
% I - решение ЗЛП (m x 1)
% w - весовые коэффициенты ЗЛП (n x 1)

function [I, w] = LP0(A, b, rad_coeff)
    [n, m] = size(A);

    h = ones(m + n, 1);
    for i = 1:m
        h(i) = 0;
    end
    
    diag_rad_b = zeros(n, n);
    for i = 1:n
        for j = 1:n
            if (i == j)
                diag_rad_b(i, j) = abs(rad_coeff * b(i));
            end
        end
    end

    C = [A
        -A];
    D = [-diag_rad_b
         -diag_rad_b];
    C = [C D];
    
    d = [b
        -b];

    lb = zeros(m + n, 1); % z >= 0
    
    % signature "x = linprog(f, A, b, Aeq, beq, lb, ub)"
    % find z |
    %  z = min_z(h^T*z)
    %  Cz <= d
    %  z >= 0   (z >= lb)  
    
    Iw = linprog(h, C, d, [], [], lb, [], []);
    
    if isempty(Iw)
        I = [];
        w = [];
        fprintf('Solution doesn`t exist!');
        return;
    end
    
    I = Iw(1:m, :);
    w = Iw(m+1:m+n, :);
    
end

 