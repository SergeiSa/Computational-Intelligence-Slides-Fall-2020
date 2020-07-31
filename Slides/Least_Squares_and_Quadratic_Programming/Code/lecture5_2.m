

n = 7;
A = randn(n);
D = randn(n);
b = randn(n, 1);
f = randn(n, 1);


N = null(A);

x_analytic = pinv(A)*b - N*pinv(D*N)* (D*pinv(A)*b + f);
error = A*x_analytic-b;

disp(['x_analytic, error norm is: ', num2str(norm(error))]);


%%%%%%%%%%%%
% check

cvx_begin
variables x(n);
minimize( norm(D*x + f) );
subject to
    A*x == b;
cvx_end

x_cvx = x;

error = A*x_cvx-b;
disp(['x_cvx, error norm is: ', num2str(norm(error))]);

[x_analytic, x_cvx]
[norm(x_analytic), norm(x_cvx)]


