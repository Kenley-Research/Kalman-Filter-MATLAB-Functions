clear;
clc;

% Table 6 algorithm

% initial set up of inputs
% k = 0;
% Z = [0.0101];
% u = [0.0101; 0.1188];
% B_or_sigma = [0 0; 0 0];
% V = [2; 2];
% R = [0.01];
% H = [1 0];


% initial set up of inputs
k = 0;
Z = [3; 4];
u = [1; 2];
B_or_sigma = [4 1; 1 9];
V = [0; 0];
R = [1 0; 0 4];
H = [0 2; 3 0];
n = size(u);

% initial set up of inputs
% k = 0;
% Z = [0.0101];
% u = [0.0101; 0.1188];
% B_or_sigma = [0.01071225 0.017495523; 0.017495523 2.04175521];
% V = [0; 0];
% R = [0.01];
% H = [1 0];
% n = size(u);


[u V B] = Mupdate(k, Z, u, B_or_sigma, V, R, H)
[X] = INFtoCOV(V, B, n)
