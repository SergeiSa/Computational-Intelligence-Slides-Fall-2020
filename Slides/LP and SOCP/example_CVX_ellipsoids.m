clear; close all;
%some sections from the following project are used:
%http://web.cvxr.com/cvx/examples/cvxbook/Ch08_geometric_probs/html/max_vol_ellip_in_polyhedra.html

n = 2; 
V = randn(20, n);
k = convhull(V);
P = V(k, :);

[domain_A, domain_b] = vert2con(P);
m = size(domain_A, 1);

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


Pe = [P; P(1, :)];
plot(P(:, 1), P(:, 2), 'o'); hold on;
plot(Pe(:, 1), Pe(:, 2))

noangles = 100;
angles   = linspace( 0, 2*pi, noangles );
ellipse_inner  = B * [ cos(angles) ; sin(angles) ] + d * ones( 1, noangles );
plot( ellipse_inner(1,:), ellipse_inner(2,:), 'r--' );

plot(d(1), d(2), 'o'); hold on;

axis equal;

