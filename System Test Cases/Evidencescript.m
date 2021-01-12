clc;
clear;

% Table 3 algorithm

% initial set up of inputs
n0 = 1;
n1 = 2;
n2 = 0;

% Input for test cases
u = [0; 0; 0];
du = u;
% B = [0 1; 0 0];
% B = [0 1 0.5; 0 0 0; 0 0 0];
% B = [0 1 0.25; 0 0 0; 0 0 0];
% V = [inf; 1; 1];
% X1 = [80]; 
% X1 = [80; 37];

% call function Table 3
 [u B V] = Evidence(u, B, V, X1, n0, n1, n2, du);
 
% [V B] = Table5(V, B, 0, n0, 1, 0);
fprintf('\nFinal Results: ');

% display the results
u
B
V
