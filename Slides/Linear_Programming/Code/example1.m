clear; close all;

V = randn(10, 2);
k = convhull(V);
P = V(k, :);

[domain_A, domain_b] = vert2con(P);
norm_A = vecnorm(domain_A');

f = [-1; 0; 0];
A = [reshape(norm_A, [], 1), domain_A];
b = domain_b;

x = linprog(f, A,b, [], []);

center = [x(2),x(3)];
r = x(1);

Pe = [P; P(1, :)];
plot(P(:, 1), P(:, 2), 'o'); hold on;
plot(Pe(:, 1), Pe(:, 2))

h = circle(center(1),center(2),r); 
axis equal;






function h = circle(x,y,r)
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = plot(xunit, yunit);
end