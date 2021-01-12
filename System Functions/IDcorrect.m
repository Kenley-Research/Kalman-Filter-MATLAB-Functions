function [xcorr Pcorr] = IDcorrect(filter, zmeas, zcov)
%% IDcorrect
% Object orientated programming
%% Inputs
% *filter -
% *zmeas -
% *zcov -
%% Outputs
% *xcorr -
% *Pcorr -
%%Description
%
%%Author
% C. Robert Kenley, PhD
% kenley@purdue.edu

u = filter.State;
P = filter.StateCovariance;
H = filter.MeasurementModel;
F = filter.StateTransitionModel;
Qk = filter.ProcessNoise;
M = size(Qk);
Vzeros = zeros([M(1) 1]);
I = eye(M);


[u V B] = Mupdate(0, zmeas, u, P, Vzeros, zcov, H)

[col_L row_L] = size(B);
L = col_L;
B = INFtoCOV(V, B, L);

xcorr = u
Pcorr = B


end