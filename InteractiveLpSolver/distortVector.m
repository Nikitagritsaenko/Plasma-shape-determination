% function b = distortVector(b0, error_coeff, distortions)
%
% ¬носит возмущени€ в вектор b0 
%
% ¬ходные данные
%
% b0 - вектор, в который хотим внести возмущение
% error_coeff - величина возмущени€ (например, error_coeff = 0.1 ~ +-10%)
% distortions - заранее определЄнный вектор случайных чисел от 0 до 1. ≈сли
% его не передать, то генерируетс€ случайное возмущение вектора b0
%
% ¬ыходные данные
%
% b - возмущЄнный вектор
function b = distortVector(b0, error_coeff, distortions)
    b = b0;

    for i = 1:size(b, 1)
        if isempty(distortions)
            r = rand();
        else
            r = distortions(i);
        end
        b(i) = b(i) + error_coeff * (2 * r - 1) * b(i);
    end

end