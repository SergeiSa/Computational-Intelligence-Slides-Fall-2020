close all; clear;

n = 5; m = 2;
A = randn(n, n);
B = randn(n, m);

Q = eye(n)*0.1;

K_lqr = lqr(A, B, eye(n), eye(m));

cvx_begin sdp
    variable P(n, n) symmetric
    variable Z(m, n)
    
    minimize 0
    subject to
    	P >= 0;
        A*P + P*A' + B*Z + Z'*B' + Q <= 0;
    
cvx_end

P = full(P);
Z = full(Z);

K_LMI = Z*pinv(P);

disp('K_lqr eig:')
eig(A - B*K_lqr)
disp('K_LMI eig:')
eig(A + B*K_LMI)