% function [I, probes, currents] = generate(n, m)
%
% ���������� ����������� ������� ����� � ��������� ��������, � �����
% ��������� ������ ����� � ������� �������. ������� ������������� ��
% ��������, � ���� �� �������
%
% ������� ������
%
% n - ����� ��������� ��������
% m - ����� ������� �����
% real_data - ������, ����� �� ������ ������ �� ����� ������ ���������
%
% �������� ������
%
% I - ������ (1 x m), �������� ���� � ������� �������
% probes - ��������� ��������
% currents - ��������� ������� �����

function [I, probes, currents] = generate(n, m, real_data)

    I_vector = zeros(m, 1);
    for i = 1:m
        I_vector(i) = 1 + abs(rand()) * 5;
    end
    I = 1e6 * I_vector;
        
    probes = [];
    currents = [];
    
    r_in = 0.125; % ������ ������ ��������
    
    % ������� ��������� �������� � �����
    x_min = 0.1; x_max = 0.7;
    y_limit = 0.6; y_min = -y_limit; y_max = y_limit;
    
    % ��������� ������� ��� ����������� �����
    a = 0.15; b = 0.3;
    ellipse1 = @(y)(a+x_min + a*sqrt(1-y*y/(b*b)) + r_in);
    ellipse2 = @(y)(a+x_min - a*sqrt(1-y*y/(b*b)) + r_in);    
   
    limiter = readmatrix('data\lim.txt') / 100;
    probes = [];
    
    if real_data
        probes = readmatrix('data\probes21.txt') / 1000;
        probes = probes(:, 1:2);
    else
        % ����������� ������� �� ��������
        k = size(limiter, 1);

        s = 1; % ��������� ����� �� ��������
        while limiter(s, 1) <= r_in
            s = s + 1;
        end

        e = k; % �������� ����� �� ��������
        while limiter(e, 1) <= r_in
            e = e - 1;
        end

        step = (e - s) / (n - 1);
        for i = 1:n
            ind = floor(s + (i-1) * step);

            new_probe = limiter(ind, :);
            probes = [probes
                      new_probe];
        end
    end
    
    % ����������� ���� �� �������
    
    r = 0.9; % �������� ������� (�������)
    if mod(m, 2) == 0
        step_current = 2 * (2 * b * r)  / (m-1);
    else
        step_current = 2 * (2 * b * r)  / (m-2);
        currents = [currents 
                    [ellipse1(b), b]
                   ];
    end
    
    for y = -b*r:step_current:b*r
        x1 = ellipse1(y);
        x2 = ellipse2(y);
        new_current1 = [x1 y];
        new_current2 = [x2 y];
        currents = [currents 
                    new_current1
                    new_current2];
    end
    
end
    