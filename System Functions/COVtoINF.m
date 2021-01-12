function [B V P] = COVtoINF(X, domain) % Table 2 algorithm
%% COVtoINF
% Converts covariance form to influence diagram form
%% Inputs
% *X - Gaussian distribution
% *domain - the number of row and colums of X
%% Outputs
% *B - an n x n matrix of Gaussian influence diagram arc coefficients which
% is strictly upper triangular
% *V - an n x 1 matrix of Gaussian influence diagram conditional variances
% with entries that are non-negative (including inf)
% *P - the (Moore-Penrose generalized) inverse of X
%%Description
% This function transforms the multivariate gaussian distribution form to
% influence diagram form.
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

P = zeros(domain, domain);
V = zeros(1,domain);
B(1,1) = 0;
V(1) = X(1,1);

if V(1) == 0 | V(1) == inf
    P(1,1) = 0;
else
    P(1,1) = 1/V(1);
end

for j = 2:domain
    B(j,j) = 0;
    B(j,1:j-1) = 0;
    B(1:j-1,j) = P(1:j-1,1:j-1)*X(1:j-1,j);
    if X(j,j) == inf
        V(j) = inf;
    else
        V(j) = X(j,j) - dot(X(j,1:j-1), B(1:j-1,j));
        V(j) = max(V(j), 0);
    end
    
    if V(j) == 0 | V(j) == inf
        P(j,j) = 0;
        P(j,1:j-1) = 0;
        P(1:1-j,j) = 0;
    else
        P(j,j) = 1/V(j);
        for k = 1:j-1
            temp = P(j,j)*B(k,j);
            if k ~= 1
                P(k,1:k-1) = P(k,1:k-1) + temp*B(1:k-1,j)';
                P(1:k-1,k) = P(k,1:k-1);
            end
            P(k,k) = P(k,k) + temp*B(k,j);
        end
        P(j,1:j-1) = -P(j,j)*B(1:j-1,j);
        P(1:j-1,j) = P(j,1:j-1);
    end
end
V = V';
end
