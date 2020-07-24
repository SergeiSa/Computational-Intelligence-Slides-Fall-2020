

M = [1 0 1; 0 5 0; 1 0 3];
C = [1 7 2];
y = 1;

cvx_begin
variables x(3);
minimize( x' * M * x );
subject to
    C*x == y;
cvx_end


disp(['Residual of the SVD solution: ', num2str(norm(C*x - y)), '; norm of the solution: ', num2str(norm(x))])

Count = 100;
tic;
for i = 1:Count
cvx_begin quiet
variables x(3);
minimize( x' * M * x );
subject to
    C*x == y;
cvx_end
end
toc