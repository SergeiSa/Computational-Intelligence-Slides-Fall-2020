clear; close all;
%some sections from the following project are used:
%http://web.cvxr.com/cvx/examples/cvxbook/Ch08_geometric_probs/html/max_vol_ellip_in_polyhedra.html

n = 3; 
P = randn(20, n)*(rand(3, 3) + eye(3));
m = size(P, 1);

% formulate and solve the problem
cvx_begin
    variable A(n,n) symmetric
    variable b(n)
    maximize( det_rootn( A ) )
    subject to
       for i = 1:m
           norm( (A*P(i,:)' + b), 2 ) <= 1;
       end
cvx_end

plot3(P(:, 1), P(:, 2), P(:, 3), 'o'); hold on;

[k1,av1] = convhull(P(:, 1), P(:, 2), P(:, 3));
trisurf(k1, P(:, 1), P(:, 2), P(:, 3),'FaceColor','r', 'FaceAlpha', 0.05);

E = pinv(A);
v = -E*b;

plot3(v(1), v(2), v(3), 'o', 'MarkerFaceColor', 'r'); hold on;

% L = eig(E);

[x,y,z] = sphere(20);
sh = size(x);
x = x(:);
y = y(:);
z = z(:);

PP = [x, y, z];
PP = (E*PP' + v)';

x = reshape(PP(:, 1), sh);
y = reshape(PP(:, 2), sh);
z = reshape(PP(:, 3), sh);

surf(x, y, z, 'FaceAlpha', 0.1,'FaceColor','g')
axis equal;

