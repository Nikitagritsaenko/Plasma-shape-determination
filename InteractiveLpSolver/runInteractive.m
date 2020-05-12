% function [] = runInteractive(I, probes, currents, type, error_coeff)  
%
% ��������� ������������� ������, � ������� �������� ����� ������ ���������
% ����� � �������� � ��������, ��� �������� ������� ��� � ���
%
% ������� ������:
% 
% I - ������ �����
% probes - ��������� ��������
% currents - ��������� �����
% type - ��� �������� (R ��� Z)
% error_coeff - �������� ���������� � ������ �����
% real_data - ������, ����� �� ������ ������ �� ����� ������ ���������
% time_idx - ������ �������, �� �������� ����� ��������� ��������

function [] = runInteractive(I, probes, currents, type, error_coeff, real_data, time_idx)    
    n = size(probes, 1);
    m = size(currents, 1);
    
    % ��������� ������ ����������� ��� ������ ������������
    distortions = zeros(n, 1);
    for j = 1:n
        distortions(j) = rand();
    end
    
    update(I, probes, currents, distortions, type, error_coeff, real_data, time_idx);

end