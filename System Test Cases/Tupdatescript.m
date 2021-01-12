clear;
clc;

% Table 7 algorithm

% initial set up of inputs
u = [0.0101; 0.1188];
X = [0.00516961 0.008445032; 0.008445032 2.02692169];
Phi = [1.0191 0.0099; -0.2474 0.9994];
gamma = [1 0; 0 1];
Qk = [0.002 0.002; 0.002 0.438];
n = size(X);

[B V P] = COVtoINF(X, 2);

[u B V] = Tupdate(u, B, V, Phi, gamma, Qk)
[X] = INFtoCOV(V, B, n)
