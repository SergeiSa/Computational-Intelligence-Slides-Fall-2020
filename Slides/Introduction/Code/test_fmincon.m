

M = [1 0 1; 0 5 0; 1 0 3];
C = [1 7 2];
y = 1;

fnc = @(x) x'*M*x;
con = @(x) deal([], C*x-y);

x = fmincon(fnc, zeros(3, 1), [],[],[],[],[],[], con)

disp(['Residual of the fmincon solution: ', num2str(norm(C*x - y)), '; norm of the solution: ', num2str(norm(x))])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

options = optimoptions('fmincon', 'Display', 'none');

Count = 1000;
tic;
for i = 1:Count
x = fmincon(fnc, zeros(3, 1), [],[],[],[],[],[], con, options);
end
toc