function [u B V] = Kalman(k, Z, u, X, V, R, H, Phi, gamma, Qk, Form)
%% Kalman
% Apply Kalman filter at time k
%% Inputs
% *k - desired discrete time.
% *Z - z(k) is a p x 1 vector of measurement values at discrete time k.
% *u - an n x 1 vector that represents the mean of the state X(k) at discrete
% time k.
% *X - If k = 0, the n x n covariance matrix of state X(k) at discrete time
% k, which must be a positive, semidefinite matrix and have non-negative
% (including inf) entries on the diagonal. If k ≠ 0,, the n x n matrix of
% Gaussian influence diagram arc coefficients of state X(k) at discrete
% time k, which must be strictly upper triangular.
% *V - If k ≠ 0, an n x 1 vector of Gaussian influence digram conditional
% variances with entries that are non-negative (including inf). If k = 0,
% this input is ignored.
% *R - the p x p diagonal measurement noise covariance matrix R, which must
% have positive (not including inf) diagonal entries.
% *H - the p x p measurement matrix at discrete time k that maps the State
% X(k) at discrete time k to the measurement z(k) at discrete time k.
% *Phi - the n x n state transition matrix Phi(k) that propagates the state
% vector X(k) at discrete time k to discrete time k+1.
% *gamma - the n x r process noise matrix Gamma(k) that maps the process
% noise vector w(k) at discrete time k to the state vector X(k) at discrete
% time k.
% *Qk - the r x r process noise covariance matrix of the process noise
% vector w(k) at discrete time k. It must be a positive, semidefinite
% matrix and must have non-negative (including inf) entries on the
% diagonal.
% *Form - 1 or 0 to determine the output's form (COV or INF).
% *convert - Set convert = 0 if the result is to reported in ID form.
% Otherwise the result will be reported to covariance form.
%% Outputs
% *A - The estimated value represented in either covariance form or
% influence diagram form.
%%Description
% The main function of the system. By calling Mupdate and Tupdate, Kalman
% creates an estimate value based on the measured vector z, desired
% discrete time k and other variables from the mathematical model for
% discrete-time Kalman filtering that follows Bryson and Ho (1975, 360).
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

[col_X row_X] = size(X);
domain = col_X;
n = domain;
[col_p row_p] = size(Z);
p = col_p;

%Preform measurement update
[u V B] = Mupdate(k, Z, u, X, V, R, H);
u_new = [u(1:n, 1)] 
V_new = [V(1:n, 1)]
B_new = [B(1:n, 1:n)]

%Preform time update
[u B V] = Tupdate(u_new, B_new, V_new, Phi, gamma, Qk);

[col_L row_L] = size(B);
L = col_L;

%Convert back to covariance form
if Form == 1;
    B = INFtoCOV(V, B, L);
end
    u
    B
    V   
end

