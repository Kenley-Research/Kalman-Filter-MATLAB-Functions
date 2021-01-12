function [xpred Ppred] = IDpredict(filter)
%% IDpredict
% Object orientated programming
%% Inputs
% *filter -
% *zmeas -
% *zcov -
%% Outputs
% *xpred -
% *Ppred -
%%Description
%
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

u = filter.State;
B_old = filter.StateCovariance;
H = filter.MeasurementModel;
F = filter.StateTransitionModel;
Qk = filter.ProcessNoise;
M = size(Qk);
I = eye(M);

[B_old V_old Precision] = COVtoINF(B_old, M(1));
[u B V] = Tupdate(u, B_old, V_old, F, I, Qk);
[Ppred] = INFtoCOV(V, B, M(1))

xpred = u;

end