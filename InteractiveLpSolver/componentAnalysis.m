% пока черновой вариант
% функция возможно и не пригодится
function [dim, err] = componentAnalysis(A, x)  
    AtA = A' * A;
    m = size(AtA, 1);
    
    % решаем Vc = x
    [V, D] = eig(AtA);
    lambdas = diag(D);
    
%     [U1, S1, V1] = svd(A,'econ');
%     diag(S1'*S1)

    c = V \ x; 
    
    % находим индексы главных компонент
    av = mean(lambdas);
    main_indices = [];
    for i=1:m
        if lambdas(i) > av
            main_indices = [main_indices i];
        end
    end
    
    expected_res = (AtA)*x;
    approx_res = zeros(m, 1);
    for i=1:length(main_indices)
        j = main_indices(i);
        approx_res = approx_res + lambdas(j) * V(:, j) * c(j);
    end

    dim = length(main_indices);
    err = norm(expected_res - approx_res) / norm(expected_res);
end