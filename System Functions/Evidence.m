function [u B V] = Evidence(u, B, V, X1, n0, n1, n2, du) % Table 3 algorithm
%% Evidence
% Enter evidence in influence diagram
%% Inputs
% *u - A matrix with values including the mean of the state X(k) at discrete
% time k and the product of this mean and measurement matrix at discrete 
% time k that maps the state X(k)
% *B - Matrix composed of covariance matrix of state X(k) and the measurement
% matrix at discrete time k.
% *V - A vector combining conditional% variances with entries that are
% non-negative (including inf) and the measurement noise values.
% *X1 - Vector of n1 values with evidence in multivariate Gaussian with
% Influence Diagram form, domain {1:n}, and ordered so that B is upper
% triangular.
% *n0 - Value that is the size of X0, where X0 is the predecessor of X1
% *n1 - Value that is the size of X1
% *n2 - Value that is the size of X2, where X2 is the successor of X1
% *du - the change in u caused by the observed variable
%% Outputs
% *u - The new n x 1 mean vector of the state X(k) changed by the effect of
% the observed variable.
% *B - An n x n matrix comprised of strictly upper triangular submatrices B
% B(1:n0,1:n0), B(n0+1:n0+n1,n0+1:n0+n1), B(n0+n1+1:n0+n1+n2,
% n0+n1+1:n0+n1+n2, and B(n0+n1+n2+1:n0+n1+n2+n3, n0+n1+n2+1:n0+n1+n2+n3)
% and B(n0+1:n0+n1:n0+n1+1,n0+n1+2) set to 0 along with the set of observed
% values.
% *V - An n x 1 vector with entries that are non-negative (including
% inf) with the observed value set to 0.
%%Description
% This function simulates the process of instantiation to update the
% estimated value with the measurement matrix.
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

for j = 1:n1
    [B V] = Reversal(B, V, 0, n0 + j - 1, 1, n1 - j + n2);
    du(n0+j) = X1(j) - u(n0+j);
    du(1:n0) = du(n0+j)*B(n0+j,1:n0);
    
    if n0+n1+n2 >= n0+j+1
        du(n0+j+1: n0+n1+n2) = du(n0+j)*B(n0+j,n0+j+1:n0+n1+n2);
    end
    
    if n0 >= 2
        for k = 2:n0
            du(k) = du(k) + dot(B(1:k-1, k), du(1:k-1));
        end
    end
    
    u(1:n0) = u(1:n0) + du(1:n0);    
    
    if n1 + n2 >= j + 1
        for k = n0+j+1:n0+n1+n2
            du(k) = du(k) + dot(B(1:n0, k), du(1:n0));
            du(k) = du(k) + dot(B(n0+j+1:n0+n1+n2, k), du(n0+j+1:n0+n1+n2));
            u(k) = u(k) + du(k);
        end
    end
    
    u(n0 + j) = 0;
    V(n0 + j) = 0;
    B(n0+j, 1:n0+n1+n2) = 0;
end
end

