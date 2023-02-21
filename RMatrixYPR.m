function R = RMatrixYPR(Alpha,Beta,Gamma)
%RMatrixYPR - Description
%
% Syntax: R = RMatrixYPR(Alpha,Beta,Gamma)
%
% Long description
% Compute Rotation Matrix based Alpha, Beta, Gamma
R_zAlpha = [cos(Alpha) -sin(Alpha) 0; sin(Alpha) cos(Alpha) 0; 0 0 1];
R_yBeta = [cos(Beta) 0 sin(Beta); 0 1 0; -sin(Beta) 0 cos(Beta)];
R_xGamma = [1 0 0; 0 cos(Gamma) -sin(Gamma); 0 sin(Gamma) cos(Gamma)];
R = R_zAlpha*R_yBeta*R_xGamma;
    
end