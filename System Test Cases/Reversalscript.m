clc;
clear;

% Table 5 algorithm

% initial set up of inputs
n0 = 2;
n1 = 2;
n2 = 2;
n3 = 0;

% vector V Test cases 1 to 5
% V = [16 1 36];
% V = [16 1 36 49];
% V = [16 1 36 49];
% V = [16 1 36 49 4 25];
% V = [inf inf 70 49.271 0 0 ];
V = V';

% matrix B Test cases 1 to 5
% B = [0 0.5 -1.75; 0 0 5; 0 0 0];
% B = [0 0.5 -1.75 -0.125; 0 0 5 0.5; 0 0 0 -0.5; 0 0 0 0];
% B = [0 0.5 -1.75 -0.125; 0 0 5 0.5; 0 0 0 -0.5; 0 0 0 0];
% B = [0 0.5 -1.75 -0.125 1 0.5; 0 0 5 0.5 -1 0.5; 0 0 0 -0.5 1 -0.5; 0 0 0 0 1 0.5; 0 0 0 0 0 0.5; 0 0 0 0 0 0];
% B = [0 0 0 0 0 0; 0 0 0 0 0 0; 0 0 0 -0.4428571 1.01826616 0.18324152; 0 0 0 0 1.00898811 1.0266744; 0 0 0 0 0 0; 0 0 0 0 0 0];

% function call
[B V] = Reversal(B, V, n0, n1, n2, n3);

% display the result
V
B