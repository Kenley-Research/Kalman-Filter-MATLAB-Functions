# Influence Diagram Implementation of Discrete-Time Filtering
This program is based on the process of removing errors and measurement noise into a value’s estimate in order to accurately predict the value at the next time step. The importance of which can be summarized from Bryson and Ho’s book, Applied Optimal Control:
> In practice, the individual state variables cannot be determined exactly by direct measurements; instead, we usually find that the measurements that can be made are functions of
> the state variables and that these measurements contain random errors. The system itself may also be subjected to random disturbances. In many cases, we have too few
> measurements at a given time to infer the state variables at that time, even if the measurements were quite precise. On occasion, we have more than enough measurements, so that
> the state variables are overdetermined. Thus, we are faced with the problem of making good estimates of the state variables from either too few or too many measurements, which
> are imprecise and only functions of the state variables, knowing, too, that the system itself is subjected to random disturbances. (Bryson and Ho 348)

# Program Overview
There is a total of 20 MATLAB scripts included in this repository, the 10 program functions and 10 scripts to run test cases. The three main functions of the system are KFupdate, IDcorrect and IDpredict that are used to call the others. Under these are two other subsystems of functions, Mupdate and Tupdate. Mupdate updates the estimated value and Tupdate predicts the state at the next time step. The relationship between these functions can be seen in the figure below. 

![alt text](https://github.com/pecollins917/test/blob/main/FunctionTree.jpg?raw=true)
![alt text](https://github.com/pecollins917/test/blob/main/Step1.jpg?raw=true)
