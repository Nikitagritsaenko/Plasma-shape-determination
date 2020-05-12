% function update(varargin)
%
% ��������� ���������� �� ������������� ������� � ������������ � ������
% ����������� ����� � ��������
%
% ������� ������:
% 
% I - ������ �����
% probes - ��������� ��������
% currents - ��������� �����
% distortions - ������ ����� ������ ����� (�������� �� 0 �� 1). ���� ������
% �������� ��������� �������, �� �� ���������� ��� �������������� �
% �������� (��� ��������� ��������� �����)
% type - ��� �������� (R ��� Z)
% error_coeff - �������� ���������� � ������ �����
% real_data - ������, ����� �� ������ ������ �� ����� ������ ���������
% time_idx - ������ �������, �� �������� ����� ��������� ��������

function update(varargin)
    
    I = varargin{1};
    probes = varargin{2};
    currents = varargin{3};
    distortions = varargin{4};
    type = varargin{5};
    error_coeff = varargin{6};
    real_data = varargin{7};
    time_idx = varargin{8};
    
    cla(subplot(3, 3, [5 8]));
    subplot(3, 3, [5 8]);

    plotTokamakSection(I, probes, currents, distortions, type, error_coeff, true, real_data, time_idx);

    cla(subplot(3, 3, [4, 7]));
    cla(subplot(3, 3, [6, 9]));
    cla(subplot(3, 3, 1));
    cla(subplot(3, 3, 2));
    cla(subplot(3, 3, 3));
    
    [Ar, Az] = findField(I, probes, currents);
    if type == 'R'
        A = Ar;
    else
        A = Az;
    end
        
    time = -1;
    if ~real_data
        b0 = A * I;
        b = distortVector(b0, error_coeff, distortions);
    else
        n = size(probes, 1);
        [b, time] = readRealData(time_idx, n);
        b0 = b;
    end
    
    solveAndDraw(A, b0, b, I, error_coeff, probes, currents, distortions, type, real_data, time_idx, time)
end