function [P, N] = pinv_null(A, tol)
%PINV   Pseudoinverse.
%NULL   Null space.


[U,S,V] = svd(A);

s = diag(S);
r = sum(s > tol);
r1 = r+1;

[~,n] = size(A);
N = V(:,r+1:n);

V(:,r1:end) = [];
U(:,r1:end) = [];
s(r1:end) = [];
s = 1./s(:);
P = (V.*s.')*U';
