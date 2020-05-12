% [ratio_MLS_LP] = compareMLSandLP(error_coeff)
% 
% Сравнивает решения по МНК и ЛП для различных конфигураций (n, m)
% 
% Входные данные
%
% error_coeff - погрешность датчиков
% num_tests - количество тестов на каждую конфигурацию
%
% Выходные данные
%
% Матрица ratio_MLS_LP - отношение ошибок MLS и LP
function [ratio_MLS_LP] = compareMLSandLP(error_coeff, num_tests)

    rad_coeff = 0.1;
    
    m_min = 2; m_max = 20;
    n_min = 6; n_max = 30;

    err_MLS = zeros(n_max, m_max);
    err_LP = zeros(n_max, m_max);
    ratio_MLS_LP = zeros(n_max, m_max);

    num_cases_lp_better = 0;
    
    for m = m_min:1:m_max
        for n = n_min:1:n_max
            [I0, probes, currents] = generate(n, m);
            [Ar, Az] = findField(I0, probes, currents);

            A = Az;
            b0 = A * I0;

            err_mls_sum = 0;
            err_lp_sum = 0;

            for i = 1:num_tests
                b = distortVector(b0, error_coeff, []);
                [I_lp, ~] = LP(A, b, rad_coeff);
                I_mls = inv(A' * A) * A' * b;

                err_mls = norm(I_mls - I0) / norm(I0);   
                err_lp = norm(I_lp - I0) / norm(I0);
                   
                if err_mls > err_lp
                    num_cases_lp_better = num_cases_lp_better + 1;
                end 
                    
                err_mls_sum = err_mls_sum + err_mls; 
                err_lp_sum = err_lp_sum + err_lp;
            end
            
            err_MLS(n, m) = err_mls_sum / num_tests;
            err_LP(n, m) = err_lp_sum / num_tests;
        end
    end

    ratio_MLS_LP = err_MLS ./ err_LP;
    ratio_MLS_LP = ratio_MLS_LP(n_min:n_max, m_min:m_max);
    ratio_binary = ratio_MLS_LP > 1;
    
    figure('color', 'white');
    hold on;
    title('MLS to LP error ratio (white - LP better)');
    colormap hot;
    clims = [0 1];
    imagesc(ratio_binary, clims);
    colorbar;
    
    num_cases = (m_max - m_min + 1) * (n_max - n_min + 1) * num_tests
    lp_efficiency = num_cases_lp_better / num_cases
end