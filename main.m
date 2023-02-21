%This project is used for 3D pose graph optimization including poses and landmarks
close all;
clc;
clear all;

% load data
Marker_1_T_true = [1.4, 0.4, 0]'; % Marker 1 position
Marker_1_YPR_true = [pi/4, pi/6, -pi/8]'; % Marker 1 YPR

Marker_1_R_true = RMatrixYPR(Marker_1_YPR_true(1),Marker_1_YPR_true(2),Marker_1_YPR_true(3));

Camera_1_T_true = [1.4, 0.4, 1]'; % Camera 1 position
Camera_2_T_true = [1.3, 0.5, 0.9]'; % Camera 2 position
Camera_3_T_true = [1.2, 0.5, 0.8]'; % Camera 3 position

Camera_1_YPR_true = [-0.01, 0.01, 0.02]'; % Camera 1 YPR
Camera_2_YPR_true = [0.5, 0.4, -0.3]'; % Camera 2 YPR
Camera_3_YPR_true = [-0.1, 0.3, 0.2]'; % Camera 3 YPR


%% generate observations 

Zstate=[];

% initial marker pose and observations
% noise level for generating data
sigma_T=0.01*0; % m, 
sigma_R=0.01*0; % rad, 2*pi/180=0.0349

% Marker initial pose
Marker_1_T_mea = Marker_1_T_true + sigma_T*randn(3,1);
Marker_1_YPR_mea = Marker_1_YPR_true + sigma_R*randn(3,1);

obs_marker_1=[Marker_1_T_mea;Marker_1_YPR_mea];

Zstate=[Zstate;obs_marker_1, ones(6,1), 1*ones(6,1), zeros(6,1)];

%% camera observe marker
%% transformation from Marker to Camera Pose
[relative_M1C1_T_true, relative_M1C1_YPR_true] = FuncRelative12(Marker_1_T_true,Marker_1_YPR_true,Camera_1_T_true,Camera_1_YPR_true);

%pause
relative_M1C1_T_mea = relative_M1C1_T_true + sigma_T*randn(3,1);
relative_M1C1_YPR_mea = relative_M1C1_YPR_true + sigma_R*randn(3,1);

obs_M1C1=[relative_M1C1_T_mea;relative_M1C1_YPR_mea];
Zstate=[Zstate; obs_M1C1, ones(6,1), 2*ones(6,1), 1*ones(6,1)];

%
[relative_M1C2_T_true, relative_M1C2_YPR_true] = FuncRelative12(Marker_1_T_true,Marker_1_YPR_true,Camera_2_T_true,Camera_2_YPR_true);
%pause

relative_M1C2_T_mea = relative_M1C2_T_true + sigma_T*randn(3,1);
relative_M1C2_YPR_mea = relative_M1C2_YPR_true + sigma_R*randn(3,1);

obs_M1C2=[relative_M1C2_T_mea;relative_M1C2_YPR_mea];
Zstate=[Zstate; obs_M1C2, ones(6,1), 3*ones(6,1), ones(6,1)];

[relative_M1C3_T_true, relative_M1C3_YPR_true] = FuncRelative12(Marker_1_T_true,Marker_1_YPR_true,Camera_3_T_true,Camera_3_YPR_true);

relative_M1C3_T_mea = relative_M1C3_T_true + sigma_T*randn(3,1);
relative_M1C3_YPR_mea = relative_M1C3_YPR_true + sigma_R*randn(3,1);

obs_M1C3=[relative_M1C3_T_mea;relative_M1C3_YPR_mea];
Zstate=[Zstate; obs_M1C3, ones(6,1), 4*ones(6,1), ones(6,1)];

% add one relative pose between camera 1 and camera 2; for testing, 

[relative_C1C2_T_true, relative_C1C2_YPR_true] = FuncRelative12(Camera_1_T_true,Camera_1_YPR_true,Camera_2_T_true,Camera_2_YPR_true);
%pause

relative_C1C2_T_mea = relative_C1C2_T_true + sigma_T*randn(3,1);
relative_C1C2_YPR_mea = relative_C1C2_YPR_true + sigma_R*randn(3,1);

obs_C1C2=[relative_C1C2_T_mea;relative_C1C2_YPR_mea];
Zstate=[Zstate; obs_C1C2, ones(6,1), 3*ones(6,1), 2*ones(6,1)];
% 
%% the whole Zstate and covariance matrix inverse
Zstate=Zstate;
CovMatrixInv=speye(size(Zstate,1),size(Zstate,1));

save data_simu Zstate CovMatrixInv