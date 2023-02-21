close all;
clc;
clear all;
tic;
load data_simu.mat

%% Initialization
[Xstate] = FuncGetInitial(Zstate);
% when measurements are perfect
Xstate_initial=Xstate;

% % % %% add noise to initial value -- perfect measurement case
 Xstate(:,2)=Xstate(:,2)+1*randn(size(Xstate,1),1);
 Xstate(1:6,2)=0; % this is important if add noise to initial value

%Xstate(7:9,2)=Xstate(7:9,2)+1*randn(3,1);

%Xstate_initial=Xstate


%pause


%% Least Squares
[Xstate,Reason,Info] = FuncLeastSquares(Zstate,CovMatrixInv,Xstate);

%% Report
fprintf('Reason is %d\n', Reason);
BATime = toc;
fprintf('Time Use %d\n\n', BATime);

% %pause

diff_Xstate=Xstate-Xstate_initial;


%% Plot
GMap.st = Xstate;
[Pose] = FuncPlotFigure_PG3D(GMap);