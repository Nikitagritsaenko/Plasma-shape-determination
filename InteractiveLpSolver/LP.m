% [I, w] = LP(A, b, rad_coeff)
% Решает систему AI = b с помощью поставленной задачи линейного
% программирования
%
% A - матрица (n x m)
% b - вектор правой части (n x 1)
% rad_coeff - коэффициент для радиусов правой части: rad{b_i} = rad_coeff * b_i
% 
% I - решение ЗЛП (m x 1)
% w - весовые коэффициенты ЗЛП (2n x 1)

function [I, w] = LP(A, b, rad_coeff)
    [n, m] = size(A);

    h = ones(m + 2*n, 1);
    for i = 1:m
        h(i) = 0;
    end
    
    diag_rad_b = zeros(2*n, 2*n);
    for i = 1:2*n
        for j = 1:2*n
            if (i == j)
                ind = i;
                if ind > n
                    ind = ind - n;
                end
                diag_rad_b(i, j) = abs(rad_coeff * b(ind));
            end
        end
    end

    C = [A
        -A];
    C = [C -diag_rad_b];

    d = [b
        -b];

    lb = zeros(m + 2*n, 1); % z >= 0
    ub = [];
   
    % signature "x = linprog(f, A, b, Aeq, beq, lb, ub)"
    % find z |
    %  z = min_z(h^T*z)
    %  Cz <= d
    %  z >= 0   (z >= lb)  
    
    options = optimoptions('linprog','Algorithm','dual-simplex');
    [Iw, fval,exitflag,output] = linprog(h, C, d, [], [], lb, ub, options)
    
    if isempty(Iw)
        I = [];
        w = [];
        fprintf('Solution doesn`t exist!');
        return;
    end
    
    I = Iw(1:m, :);
    w = Iw(m+1:m+2*n, :);    
end

 