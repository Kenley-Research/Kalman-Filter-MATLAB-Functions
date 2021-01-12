function [xpred Ppred] = IDpredict(filter)
%% IDpredict
% Object orientated programming
%% Inputs
% *filter - A trackingKF object that contains the State, StateCovariance
% MeasurementModel, StateTransitionModel and ProcessNoise variables.
%% Outputs
% *xpred - The predicted state
% *Ppred - The predicted state estimation error covariance
%%Description
% This function is modeled after the predict function of the MATLAB sensor
% fusion tracking toolbox. It accepts a trackingKF oject as input and
% performs the Time Update, or prediction, portion of the Kalman Filter.
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
