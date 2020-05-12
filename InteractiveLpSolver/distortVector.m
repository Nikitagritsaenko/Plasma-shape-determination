% function b = distortVector(b0, error_coeff, distortions)
%
% ������ ���������� � ������ b0 
%
% ������� ������
%
% b0 - ������, � ������� ����� ������ ����������
% error_coeff - �������� ���������� (��������, error_coeff = 0.1 ~ +-10%)
% distortions - ������� ����������� ������ ��������� ����� �� 0 �� 1. ����
% ��� �� ��������, �� ������������ ��������� ���������� ������� b0
%
% �������� ������
%
% b - ����������� ������
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