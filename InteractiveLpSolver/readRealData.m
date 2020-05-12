function [b, time]  = readRealData(time_idx, n)
    probes_data_file = fopen('data\probes_data.txt','r');
    formatSpec = '%f';
    A = fscanf(probes_data_file, formatSpec);
    nt = size(A, 1) / (n+1); % ���������� �������� ������� � �����
    if time_idx > nt
        time_idx = nt;
    end
   
    A = reshape(A, n+1, nt);
    T = A(1, :); % ������� �������
    time = T(time_idx);
    B = A(2:n+1, :); % ��������� ��������
    % ��� ���� ��������� �� ��������� ��������?
    b = 1e3 * B(:, time_idx);
end