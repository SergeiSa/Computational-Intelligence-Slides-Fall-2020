clear; close all;
n = 2;

% shift = [3; 3];
% V1 = randn(n, 7);
% V2 = randn(n, 7) + shift;
% 
% indices_convhull = convhull(V1');
% V1 = V1(:, indices_convhull);
% indices_convhull = convhull(V2');
% V2 = V2(:, indices_convhull);

V1 = [0.2252   -0.4210   -0.5227    0.9258    0.2252;
    1.0522    0.9372   -0.4046   -0.6866    1.0522] + [1; 1];

V2 = [3.8322    5.1332    3.5705    2.1696    2.3500    3.8322
    1.5502    2.1321    3.0654    2.7744    2.3928    1.5502];

bigM = 8;

[A1, b1] = vert2con(V1');
[A2, b2] = vert2con(V2');

V1_relaxed = con2vert(A1, b1+bigM)';
indices_convhull = convhull(V1_relaxed');
V1_relaxed = V1_relaxed(:, indices_convhull);

figure('Color', 'w');

plot(V1(1, :)', V1(2, :)', 'o', 'MarkerFaceColor', 'g'); hold on;
graphic.h1 = fill(V1(1, :)', V1(2, :)', [0.2, 0.0, 0.8], 'FaceAlpha', '0.5'); hold on;

plot(V2(1, :)', V2(2, :)', 'o', 'MarkerFaceColor', 'g'); hold on;
graphic.h2 = fill(V2(1, :)', V2(2, :)', [0.2, 0.8, 0], 'FaceAlpha', '0.5'); hold on;

plot(V1_relaxed(1, :)', V1_relaxed(2, :)', 'o', 'MarkerFaceColor', 'g'); hold on;
graphic.h3 = fill(V1_relaxed(1, :)', V1_relaxed(2, :)', [0.8, 0, 0.8], 'FaceAlpha', '0.1'); hold on;


axis equal;
legend([graphic.h1, graphic.h2, graphic.h3], 'V1', 'V2', 'V1 relaxed')