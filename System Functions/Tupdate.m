function  [u B V] = Tupdate(u, B, V, Phi, gamma, Qk)
%% Tupdate
% Time update from X(k) to X(k+1)
%% Inputs
% *u - a n x 1 vector that represent the mean if the state X(k) at discrete
% time k
% *B - an n x n matrix of Gaussian influence diagram arc coefficients of
% state X(k) at discrete time k, which must be strictly upper triangular
% *V - an n x 1 vector of Gaussian influence diagram conditional variances
% of state X(k) at discrete time k, with entries that are non-negative
% (including inf)
% *Phi - the n x n state transition matrix Phi(k) that propagates the state
% vector X(k) at discrete time k to discrete time k+1
% *gamma - the n x r process noise matrix Gamma(k) that maps the process
% noise vector w(k) at discrete time k to the state vector X(k) at discrete
% time k
% *Qk - - the r x r process noise covariance matrix of the process noise
% vector w(k) at discrete time k. It must be a positive, semidefinite
% matrix and must have non-negative (including inf) entries on the
% diagonal.
%% Outputs
% *u - an n x 1 vector that represent the mean if the state X(k+1) at
% discrete time k+1.
% *B - an n x n matrix of Gaussian influence diagram arc coefficients of
% state X(k+1) at discrete time k+1, which must be strictly upper
% triangular.
% *V -an n x 1 vector of Gaussian influence diagram conditional variances
% of state X(k+1) at discrete time k+1, with entries that are non-negative
% (including inf).
%%Description
%The time update function preforms the update of x(k) and w(k) with x(k+1).
%The function updates the unconditional mean of x(k+1) via matrix
%multiplication, removes x(k) into x(k+1), and then removes w(k) into x(k).
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

[col_u row_u] = size(u);
[col_Qk row_Qk] = size(Qk);

n = col_u; % size of u
r = col_Qk; % size of Qk
[Bq Vq P] = COVtoINF(Qk, r);
On = zeros(n);
Or = zeros(r);
Onr = zeros(n,r);
On1 = zeros(n, 1)
Or1 = zeros(r, 1);
V_new = [Vq; V; On1];
B_new = [Bq Onr' gamma';Onr B Phi';Onr On On];

n0 = 0;
n1 = n+r;
n2 = n;
n3 = 0;
[B V] = Removal(B_new, V_new, n0, n1, n2);
V = V';
B = B(n+r+1:n+r+n, n+r+1:n+r+n)
V = V(1, n+r+1:n+r+n)';
u_New = [Phi*u]; 
u = u_New;
end

