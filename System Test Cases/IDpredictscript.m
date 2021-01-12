clear;
clc;

% Table 8 algorithm


k = 0;
zmeas = [0.0101];
u = [0.0101; 0.1188];
P = [0.00516961 0.008445032; 0.008445032 2.02692169];
%P = [0.01071225 0.017495523; 0.017495523 2.04175521];
V = [0; 0];
zcov = [0.01];
H = [1 0];
F = [1.0191 0.0099; -0.2474 0.9994];
Qk = [0.002 0.002; 0.002 0.438];

Form = 1;

filter = trackingKF(F, H, 'State', u, 'StateCovariance', P, 'ProcessNoise', Qk);


[xpred Ppred] = IDpredict(filter)

