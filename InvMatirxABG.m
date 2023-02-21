function [Alpha,Beta,Gamma] = InvMatirxABG(R)
%InvMatirxABG - Description
%
% Syntax: [Alpha,Beta,Gamma] = InvMatirxABG(R)
%
% Long description
% compute Alpha Beta Gamma from rotation matrix
Square_cos_Beta = R(1,1)^2 + R(2,1)^2;
if Square_cos_Beta > 1e-6
    Gamma = atan2(R(3,2),R(3,3));
    Beta = atan2(-R(3,1),sqrt(Square_cos_Beta));
    Alpha = atan2(R(2,1),R(1,1));
else
    Beta = pi/2;
    Alpha = 0;
    Gamma = atan2(R(2,3),R(2,2));
end