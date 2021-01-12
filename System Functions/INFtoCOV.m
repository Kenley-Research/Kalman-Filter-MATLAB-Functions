function [X] = INFtoCOV(V, B, domain) % Table 1 algorithm
%% INFtoCOV
% Converts influence diagram form to covariance form
%% Inputs
% *V - an n x 1 vector with entries that are non-negative (including inf)
% *B - an n x n matrix which is strictly upper triangular
% *domain - the number of row and columns of B
%% Outputs
% *X - the covariance matrix of the multivariate Gaussian distribution
% which is positive, semidefinite and symmetric and has non-negative
% (including inf) entries on the diagonal
%%Description
% This function transforms the gaussian distribution from influence diagram
% form to the covariance form.
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

X(1,1) = V(1);
for i = 2:domain
    for j = 1:i-1
        X(i,j) = 0;
        for k = 1:i-1
            if X(j,k) ~= inf
                X(i,j) = X(i,j) + X(j,k)*B(k,i);
            end
        end
        X(j,i) = X(i,j);
    end
    if V(i) == inf
        X(i,i) = inf
    else
        Y = X(i,1:i-1);
        Z = B(1:i-1,i);
        X(i,i) = V(i) + dot(Y,Z);
    end
end
end

