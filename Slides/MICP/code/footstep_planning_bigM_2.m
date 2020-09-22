clear; close all;
n = 2;

shift_1 = 1*rand(n, 1);
shift_2 = 1*rand(n, 1);
V1 = randn(n, 6);
V2 = randn(n, 6) + shift_1;
V3 = randn(n, 6) + shift_1 + shift_2;

indices_convhull = convhull(V1');
V1 = V1(:, indices_convhull);
indices_convhull = convhull(V2');
V2 = V2(:, indices_convhull);
indices_convhull = convhull(V3');
V3 = V3(:, indices_convhull);

[A1, b1] = vert2con(V1');
[A2, b2] = vert2con(V2');
[A3, b3] = vert2con(V3');

number_of_steps = 7; 
start_point = sum(V1, 2) / size(V1, 2);
finish_point = sum(V3, 2) / size(V3, 2);

weight_goal = 5;
bigM = 15;

cvx_begin
    variable x(n, number_of_steps)
    binary variable c(3, number_of_steps);

    cost = 0;
    for i = 1:(number_of_steps-1)
        cost = cost + norm(x(:, i) - x(:, i+1));
    end
    
    cost = cost + norm(x(:, 1) - start_point)*weight_goal;
    cost = cost + norm(x(:, number_of_steps) - finish_point)*weight_goal;

    minimize( cost )
    subject to
        
        for i = 1:number_of_steps
            A1*x(:, i) <= b1 + (1 - c(1, i))*bigM;
            A2*x(:, i) <= b2 + (1 - c(2, i))*bigM;
            A3*x(:, i) <= b3 + (1 - c(3, i))*bigM;
            
            c(1, i) + c(2, i) + c(3, i) == 1;
        end
        
cvx_end



plot(V1(1, :)', V1(2, :)', 'o', 'MarkerFaceColor', 'g'); hold on;
graphic.h1 = fill(V1(1, :)', V1(2, :)', [0.2, 0.0, 0.8], 'FaceAlpha', '0.2'); hold on;

plot(V2(1, :)', V2(2, :)', 'o', 'MarkerFaceColor', 'g'); hold on;
graphic.h2 = fill(V2(1, :)', V2(2, :)', [0.2, 0.8, 0], 'FaceAlpha', '0.2'); hold on;

plot(V3(1, :)', V3(2, :)', 'o', 'MarkerFaceColor', 'g'); hold on;
graphic.h3 = fill(V3(1, :)', V3(2, :)', [0.9, 0.0, 0.1], 'FaceAlpha', '0.2'); hold on;


plot(start_point(1, :)', start_point(2, :)', 's', 'MarkerFaceColor', 'y', 'MarkerSize', 10); hold on;
plot(finish_point(1, :)', finish_point(2, :)', 'x', 'MarkerEdgeColor', 'b', 'MarkerSize', 10, 'LineWidth', 2); hold on;

plot(x(1, :)', x(2, :)', '^', 'MarkerEdgeColor', 'k', 'MarkerSize', 10, 'LineWidth', 2); hold on;



axis equal;
legend([graphic.h1, graphic.h2, graphic.h3], 'V1', 'V2', 'V3')