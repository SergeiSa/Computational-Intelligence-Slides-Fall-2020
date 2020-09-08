close all; clear;

func = @(t) t^2;
derivative_func = @(t) 2*t;


draw_f(func);
hold on;

approx_points = [-1, -0.3, 0, 0.3, 1];
approx_points = randn(1, 10)*1;

n = length(approx_points);

a = zeros(n, 1);
b = zeros(n, 1);

for i = 1:n
    t = approx_points(i);
    
    a(i) = derivative_func(t); 
    b(i) = func(t) - a(i)*t ;
    
    temp_fnc = @(t) a(i)*t + b(i);
%     draw_f(temp_fnc);
end

fnc_m = @(t) max(a*t + b);
draw_f(fnc_m);

f = [1; 0];
lin_A = [-ones(n, 1), a];
lin_b = -b;

x = linprog(f, lin_A,lin_b, [], []);


plot(x(2), x(1), 'o', 'MarkerFaceColor', 'r');

axis equal;

function draw_f(myfunc)
myfunc2d = @(t) [t; myfunc(t)];
draw_f2d(myfunc2d);
end

function draw_f2d(myfunc)
th = -1.5:0.01:1.5;
PP = zeros(length(th), 2);
for i = 1:length(th)
    v = myfunc(th(i));
    PP(i, :) = reshape(v, 1, 2);
end
plot(PP(:, 1), PP(:, 2), 'LineWidth', 3);
end