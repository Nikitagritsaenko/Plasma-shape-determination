% function [] = plotTokamakSection(I, probes, currents, distortions, type, error_coeff, interactive, real_data, time_idx)
%
% ������ ������� ��������: �������, ����� ��������, ������� � ����. �����
% ��������� �������� �����. 
%
% ��� ����� interactive = true ����� ���������������� � ��������, 
% ����� ����� ��������� ����� � ��������. � ���� ������ ������ ������ ������� �����
% �������� � ������ ����������� ����� � ��������, � ��� ���������������
% ������� ���������������.
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
% interactive - ���� �������������� ��������������
% real_data - ������, ����� �� ������ ������ �� ����� ������ ���������
% time_idx - ������ �������, �� �������� ����� ��������� ��������

function [] = plotTokamakSection(I, probes, currents, distortions, type, error_coeff, interactive, real_data, time_idx)
    global dpt;
    
    n = size(probes, 1);
    m = size(currents, 1);
    % ��������� ������ �������� (������������ [��] � [�])
    limiter = readmatrix('data/lim.txt') / 100;
    s = size(limiter, 1);
    r_in = 0.125;

    % ������ �������
    plot(limiter(:, 1), limiter(:, 2), 'k');
    line([limiter(1, 1), limiter(s, 1)], ...
        [limiter(1, 2), limiter(s, 2)], 'color', 'k');

    % ������ ������� � ���� � ����������
    title(sprintf('Currents and probes \n(m = %i, n = %i)', m, n));
    xlim([-1,1]);
    ylim([-1,1]);
    hold on;

    for i = 1:size(currents, 1)
        if (I(i) > 0)
            h(i) = plot(currents(i, 1), currents(i, 2), 'o', ...
                'MarkerEdgeColor', 'k',...
                'MarkerFaceColor','r',...
                'MarkerSize',10);
            if interactive
                set(h(i),'UserData',n+i)
                draggable(h(i), 'endfcn', @updateCurrent);
            end
            text(currents(i, 1) + 0.04, currents(i, 2) + 0.04, sprintf('%i', i), 'FontSize', 8)
            text(-0.5, 1 - i * 0.1, ...
                sprintf('I_{%i} = %.2f', i, I(i) / 1e6), 'FontSize', 12)
        end
       
    end

    for i = 1:size(probes, 1)
        h(i) = plot(probes(i, 1), probes(i, 2), 's', ...
            'MarkerEdgeColor', 'k',...
            'MarkerFaceColor','b',...
            'MarkerSize',10);
        if interactive
            set(h(i),'UserData', i)
            draggable(h(i), 'endfcn', @updateProbe);
        end

        text(probes(i, 1) + 0.04, probes(i, 2) + 0.04, int2str(i), 'FontSize', 8)
    end
    hold on;

    % ������ ������� ������
    y_min = min(probes(:,2));
    y_max = max(probes(:,2));
    x_min = min(probes(:,1));
    x_max = max(probes(:,1));

    line([0 0], 2*[y_min y_max], 'color', 'k');
    line(0.95*[r_in r_in], 2*[y_min y_max], 'color', 'k');
    axis equal;
    
    % callback �������
    function updateProbe(varargin)
        idx = get(varargin{1,1}, 'UserData');
        probes(idx, :) = probes(idx, :) + dpt;
        update(I, probes, currents, distortions, type, error_coeff, real_data, time_idx);
    end

    function updateCurrent(varargin)
        idx = get(varargin{1,1}, 'UserData');
        currents(idx - n, :) = currents(idx - n, :) + dpt;
        update(I, probes, currents, distortions, type, error_coeff, real_data, time_idx);
    end

end