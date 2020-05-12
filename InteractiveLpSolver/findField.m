% function [Ar, Az] = findField(I, probes, currents)
%
% Вычисляет матрицы магнитного поля (Ar, Az), которые являются матрицами
% СЛАУ вида A * I = b, где неизвестен вектор токов
%
% Входные данные
%
% I - вектор токов в токовых кольцах
% probes - положения датчиков
% currents - положения токов
%
% Выходные данные
%
% Матрицы магнитного поля (Ar, Az)

function [Ar, Az] = findField(I, probes, currents)
    n = size(probes, 1);
    m = size(currents, 1);
    Ar = zeros(n, m);
    Az = zeros(n, m);

    for i = 1:n
        for j = 1:m
            % поле в i-том датчике от j-ого токового кольца
            r = probes(i, 1);
            z = probes(i, 2);

            a = currents(j, 1); % радиус токового кольца
            h = currents(j, 2); % высота токового кольца

            [Br, Bz, ~] = findB(r, z-h, a, I(j));
            Ar(i, j) = Br / I(j);
            Az(i, j) = Bz / I(j);
        end
    end
end