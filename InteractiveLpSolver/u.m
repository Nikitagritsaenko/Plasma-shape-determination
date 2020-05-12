clc
clear
A = readmatrix('data\lim.txt');

for k = 1:3
    n = size(A, 1)
    A_new = [];
    for i = 1:n-1
        A_new = [A_new
            A(i, :)];
        A_new = [A_new
               (A(i, :) + A(i+1, :)) / 2];
    end
    A_new = [A_new
             A(n, :)];  
    A = A_new;
end

save('data\limiter', A);