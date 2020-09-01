clear; close all;
%some sections from the following project are used:
%http://web.cvxr.com/cvx/examples/cvxbook/Ch08_geometric_probs/html/max_vol_ellip_in_polyhedra.html

n = 3; 
P = randn(20, n)*(rand(3, 3) + eye(3));
m = size(P, 1);

[domain_A, domain_b] = vert2con(P);

% formulate and solve the problem
cvx_begin
    variable B(n,n) symmetric
    variable d(n)
    maximize( det_rootn( B ) )
    subject to
       for i = 1:m
           norm( B*domain_A(i,:)', 2 ) + domain_A(i,:)*d <= domain_b(i);
       end
cvx_end


plot3(P(:, 1), P(:, 2), P(:, 3), 'o'); hold on;

[k1,av1] = convhull(P(:, 1), P(:, 2), P(:, 3));
trisurf(k1, P(:, 1), P(:, 2), P(:, 3),'FaceColor','r', 'FaceAlpha', 0.05);

% E = pinv(A);
% v = -E*b;

plot3(d(1), d(2), d(3), 'o', 'MarkerFaceColor', 'r'); hold on;

[x,y,z] = sphere(20);
sh = size(x);
x = x(:);
y = y(:);
z = z(:);

PP = [x, y, z];
PP = (B*PP' + d)';

x = reshape(PP(:, 1), sh);
y = reshape(PP(:, 2), sh);
z = reshape(PP(:, 3), sh);

% [x,y,z] = ellipsoid(v(1), v(2), v(3), L(1),L(2),L(3), 20);
surf(x, y, z, 'FaceAlpha', 0.1,'FaceColor','g')
% surf(PP(:, 1), PP(:, 2), PP(:, 3), 'FaceAlpha', 0.3)


axis equal;

