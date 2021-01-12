function [u V B] = Mupdate(k, Z, u, B_or_sigma, V, R, H)
%% Mupdate
% Measurement update for measurement Z(k)
%% Inputs
% *k - desired discrete time
% *Z - z(k) is a p x 1 vector of measurement values at discrete time k
% *u - a n x 1 vector that represents the mean of the state X(k) at discrete
% time k
% *B_or_sigma - If k = 0, the n x n covariance matrix of state X(k) at
% discrete time k, which must be positive, semidefinite matrix and must
% have non-negative (including inf) entries on the diagonal. If k ≠ 0, the
% n x n matrix of Gaussian influence diagram arc coefficients of state X(k)
% at discrete time k, which must be strictly upper triangular.
% *V - If k ≠ 0, an n x 1 vector of Gaussian influence diagram conditional
% variances with entries that are non-negative (including inf). If k = 0,
% this input is ignored.
% *R - the p x p diagonal measurement noise covariance matrix R, which must
% have positive (not including inf) diagonal entries.
% *H - the p x n measurement matrix at discrete time k that maps the state
% X(k) at discrete time k to the measurement z(k) at discrete time k.
%% Outputs
% *u - an n x 1 vector that represents the updated mean of the state X(k+1)
% at discrete time k+1.
% *V - an n x 1 vector of Gaussian influence diagram conditional variances
% of state X(k+1) at discrete time k=1, which has entries that are
% non-negative (including inf).
% *B - the n x n matrix of Gaussian influence diagram arc coefficients of
% state X(k+1) at discrete time k=1, which is strictly upper triangular.
%%Description
% 
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

[col_V row_V] = size(V);
domain = col_V
n = domain;
[col_p row_p] = size(Z);
p = col_p;

if k == 0
    [B V P] = COVtoINF(B_or_sigma, domain);
end

X1 = [Z];
n0 = n;
n1 = p;
n2 = 0;
u_new = [u; H*u];
du = [0; 0];
V_new = [V ; diag(R)];
Opn = zeros(p, n);
Opp = zeros(p);
B_new = [B H'; Opn Opp]

[u B V] = Evidence(u_new, B_new, V_new, X1, n0, n1, n2, du);
u = u(1:n)
B = B(1:n, 1:n)
V = V(1:n)'

end

