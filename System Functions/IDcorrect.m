function [xcorr Pcorr] = IDcorrect(filter, zmeas, zcov)
%% IDcorrect
% Object orientated programming
%% Inputs
% *filter - A trackingKF object that contains the State, StateCovariance
% MeasurementModel, StateTransitionModel and ProcessNoise variables.
% *zmeas - Measurement value
% *zcov - Covariance of measurement value
%% Outputs
% *xcorr - Corrected state of the measurement value.
% *Pcorr - Corrected state of the covariance, specified as a matrix.
%%Description
% This function is modeled after the correct function of the MATLAB
% sensor fusion tracking toolbox. IDcorrect preforms the measurement
% update processes of the Kalman filter for object orientated programming.
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
