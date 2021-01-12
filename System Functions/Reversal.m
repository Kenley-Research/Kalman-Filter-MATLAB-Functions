function [B V] = Reversal(B, V, n0, n1, n2, n3) % Table 5 algorithm
%% Reversal
% Arc reversal between two nodes
%% Inputs
% *B - an n x n matrix which is strictly upper triangular comprised of
% strictly upper triangular submatrices B(1:n0,1:n0),
% B(n0+1:n0+n1,n0+1:n0+n1), B(n0+n1+1:n0+n1+n2, n0+n1+1:n0+n1+n2, and
% B(n0+n1+n2+1:n0+n1+n2+n3, n0+n1+n2+1:n0+n1+n2+n3); with the entries in
% submatrix B(n0+1:n0+n1:n0+n1+1,n0+n1+n2) set to 0 and with entries in the
% submatrix below the diagonal B(n0+n1+1:n0+n1+n2:n0+1,n0+n1) allowed to be
% any real value.
% *V - an n x 1 vector with entries that are non-negative (including inf)
% *n0 - the size of vector node x0
% *n1 - the size of vector node x1
% *n2 - the size of vector node x2
% *n3 - the size of vector node x3
%% Outputs
% *B - an n x n matrix comprised of strictly upper triangular submatrices B
% B(1:n0,1:n0), B(n0+1:n0+n1,n0+1:n0+n1), B(n0+n1+1:n0+n1+n2,
% n0+n1+1:n0+n1+n2, and B(n0+n1+n2+1:n0+n1+n2+n3, n0+n1+n2+1:n0+n1+n2+n3)
% and B(n0+1:n0+n1:n0+n1+1,n0+n1+2) set to 0.
% *V - an n x 1 vector with entries that are non-negative (including inf)
%%Description
% This function utilizes Bayes’ rule to reverse the arcs between vector
% nodes. This function assumes a Gaussian influence diagram with four
% vector nodes x0, x1, x2, and x3. It is assumed that x0 has n0 elements;
% x1 has n1 elements, x2 has n2 elements, and x3 has n3 elements. Also, it
% is assumed that x0 is a predecessor to x1, x2, and x3 in the influence
% diagram, that x1 is a predecessor to x2 and x3 in the influence diagram.
% , and that x2 is a predecessor to x3 in the influence diagram. It
% reverses vector node x1 into vector node x2.
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

for i = n0 + n1:-1:n0 + 1
    for j = n0 + n1 + 1:n0 + n1 + n2
        if B(i,j) ~= 0
            if n0 >= 1
                B(1:n0, j) = B(1:n0, j) + B(i,j)*B(1:n0, i);
            end
            
            if i - 1 >= n0 + 1
                B(n0+1:i-1, j) = B(n0+1:i-1, j) + B(i,j)*B(n0+1:i-1, i);           
            end
            
            if j - 1 >= n0 + n1 + 1
                B(n0 + n1 + 1:j-1, j) = B(n0 + n1 + 1:j-1, j) + B(i,j)*B(n0+n1+1:j-1, i);
            end
        
            if V(i) == 0
                B(j,i) = 0;
            else
                if V(i) ~= inf & V(j) ~= inf
                    if V(j) == 0
                        V(j) = B(i,j)*B(i,j)*V(i);
                        V(i) = 0;
                        B(j,i) = 1/B(i,j);
                    else
                        Vjold = V(j);
                        V(j) =  V(j) + B(i,j)*B(i,j)*V(i);
                        Vratio = V(i)/V(j);
                        V(i) = Vjold * Vratio;
                        B(j,i) = B(i,j) * Vratio;
                    end
                else
                    if V(j) ~= inf
                        B(j,i) = 1/B(i,j);
                    else
                        B(j,i) = 0;
                    end
                    
                    if V(i) == inf & V(j) ~= inf
                        V(i) = V(j)*B(j,i)*B(j,i);
                    end
                    
                    V(j) = inf;
                end
            end                
        
            B(i,j) = 0;
            if n0 >= 1
                B(1:n0,i) = B(1:n0,i) - B(j,i)*B(1:n0,j);
            end
            
            if i - 1 >= n0 + 1
                B(n0+1:i-1, i) = B(n0+1:i-1, i) - B(j,i)*B(n0+1:i-1, j);
            end
            
            if j - 1 >= n0 + n1 + 1
                B(n0+n1+1:j-1,i) = B(n0+n1+1:j-1,i) - B(j,i)*B(n0+n1+1:j-1,j);
            end
        end
    end
end
end
