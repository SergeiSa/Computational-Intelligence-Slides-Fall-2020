clear; close all;
%some sections from the following project are used:
%http://web.cvxr.com/cvx/examples/cvxbook/Ch08_geometric_probs/html/max_vol_ellip_in_polyhedra.html

n = 2; 
V = randn(20, n);
k = convhull(V);
P = V(k, :);
m = size(P, 1);

[domain_A, domain_b] = vert2con(P);

% formulate and solve the problem
cvx_begin
    variable A(n,n) symmetric
    variable b(2)
    maximize( det_rootn( A ) )
    subject to
       for i = 1:m
           norm( (A*P(i,:)' + b), 2 ) <= 1;
       end
cvx_end


Pe = [P; P(1, :)];
plot(P(:, 1), P(:, 2), 'o'); hold on;
plot(Pe(:, 1), Pe(:, 2))

E = pinv(A);
v = -E*b;

noangles = 100;
angles   = linspace( 0, 2*pi, noangles );
ellipse_inner  = E * [ cos(angles) ; sin(angles) ] + v * ones( 1, noangles );
plot( ellipse_inner(1,:), ellipse_inner(2,:), 'r--' );

plot(b(1), b(2), 'o'); hold on;

axis equal;

