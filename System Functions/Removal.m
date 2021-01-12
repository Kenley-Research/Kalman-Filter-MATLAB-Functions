function [B V] = Removal(B, V, n0, n1, n2) % Table 4 algorithm
%% Removal
% Removal of vector nodes in gaussian influence diagram
%% Inputs
% *B - an n x n matrix which is strictly upper triangular comprised of
% strictly upper triangular submatrices B(1:n0,1:n0),
% B(n0+1:n0+n1,n0+1:n0+n1), and B(n0+n1+1:n0+n1+n2, n0+n1+1:n0+n1+n2)
% *V - an n x 1 vector with entries that are non-negative (including inf)
% *n0 - the size of vector node x0
% *n1 - the size of vector node x1
% *n2 - the size of vector node x2
%% Outputs
% *B - an n x n matrix which is strictly upper triangular comprised of
% strictly upper triangular submatrices B(1:n0,1:n0) and
% B(n0+n1+1:n0+n1+n2, n0+n1+1:n0+n1+n2); and with the entries in
% submatrices B(1:n0:n0+1,n0+n1) and B(n0+1:n0+n1:n0+n1+1,n0+n1+2) set to 0
% *V - an n x 1 vector with entries that are non-negative (including inf)
% with the entries V(n0+1:n0+n1) set to 0.
%%Description
% This function assumes a Gaussian influence diagram with three vector
% nodes x0, x1, and x2. It is assumed that x0 has n0 elements; x1 has n1
% elements, and x2 has n2 elements. Also, it is assumed that x0 is a
% predecessor to both x1 and x2 in the influence diagram that x1 is a
% predecessor to x2 in the influence diagram.  The function removes vector
% node x1 into vector node x2. This function first calls Reversal to
% reverse the  arcs from vector node x1 in vector xto the first n2-1
% elements of vector node x2 and  then utilizes the law of total
% probability to iteratively  remove elements of the vector nodesnode x1
% into the last element of vector node x2.
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

if n2 > 1 
    [B V] = Reversal(B, V, n0, n1, n2 - 1, 0);
end

N = n0 + n1 + n2;
for i = n0 + n1:-1: n0 + 1
    if n0 >= 1
        B(1:n0, N) = B(1:n0, N) + B(i,N)*B(1:n0, i);
    end
    
    if i - 1 >= n0 + 1
        B(n0+1:i-1, N) = B(n0+1:i-1, N) + B(i,N)*B(n0+1:i-1, i);
    end
    
    if N - 1 >= n0 + n1 + 1
        B(n0 + n1 + 1:N-1, N) = B(n0 + n1 + 1:N-1, N) + B(i,N)*B(n0 + n1 + 1:N-1, i);
    end
    
    if V(i) ~= 0
        if V(i) ~= inf & V(N) ~= inf
            V(N) = V(N) + B(i,N)*B(i,N)*V(i);
        else
            V(N) = inf;
        end
    end
end

V(n0+1:n0+n1) = 0;
B(n0+1:n0+n1) = 0;
B(1:n0+n1, n0+1:n0+n1) = 0;
B(n0+1:n0+n1, n0+n1+1:n0+n1+n2) = 0;
B(n0+n1+1:N, n0+1:n0+n1) = 0;
end

