% function [Ar, Az] = findField(I, probes, currents)
%
% ��������� ������� ���������� ���� (Ar, Az), ������� �������� ���������
% ���� ���� A * I = b, ��� ���������� ������ �����
%
% ������� ������
%
% I - ������ ����� � ������� �������
% probes - ��������� ��������
% currents - ��������� �����
%
% �������� ������
%
% ������� ���������� ���� (Ar, Az)

function [Ar, Az] = findField(I, probes, currents)
    n = size(probes, 1);
    m = size(currents, 1);
    Ar = zeros(n, m);
    Az = zeros(n, m);

    for i = 1:n
        for j = 1:m
            % ���� � i-��� ������� �� j-��� �������� ������
            r = probes(i, 1);
            z = probes(i, 2);

            a = currents(j, 1); % ������ �������� ������
            h = currents(j, 2); % ������ �������� ������

            [Br, Bz, ~] = findB(r, z-h, a, I(j));
            Ar(i, j) = Br / I(j);
            Az(i, j) = Bz / I(j);
        end
    end
end