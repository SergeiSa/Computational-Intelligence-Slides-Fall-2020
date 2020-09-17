clear; 

n = 7;
A1 = randn(n, n) - 0.5*eye(n);
A2 = randn(n, n) - 3*eye(n);
eig(A2)

Q = eye(n);
[res1, P1] = solve_LE(A1, Q, n);
[res2, P2] = solve_LE(A2, Q, n);

disp(['result for the A1 is ', num2str(res1)])
disp(['eig(A1) is ', mat2str(round(eig(A1)', 2) )])
if res1
disp(['eig(A1*P1 + P1*A1 + Q) is ', mat2str(round(eig (A1*P1 + P1*A1' + Q)', 2) )])
end

disp(['result for the A2 is ', num2str(res2)])
disp(['eig(A2) is ', mat2str(round(eig(A2)', 2) )])
if res1
disp(['eig(A2*P2 + P2*A2 + Q) is ', mat2str(round(eig (A2*P2 + P2*A2' + Q)', 2) )])
end


function [res, P] = solve_LE(A, Q, n)
cvx_begin sdp
    variable P(n, n) symmetric
    minimize 0
    subject to
        P >= 0;
        A*P + P*A' + Q <= 0;
cvx_end

if strcmp(cvx_status, 'Solved')
    res = true;
else
    res = false;
end
end

