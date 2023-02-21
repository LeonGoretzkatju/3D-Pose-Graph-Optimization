function dRid = FuncdRi(dR,R)
    F1 = R(2,1)/R(1,1);
    F3 = R(3,2)/R(3,3);
    F5 = R(1,1)^2 + R(2,1)^2;
    F4 = sqrt(F5);
    F2 = -R(3,1)/F4;
    dAlphadF1 = Funcdatan(F1); %Alpha
    dBetadF2 = Funcdatan(F2); %Beta
    dGammadF3 = Funcdatan(F3); %Gamma
    dF1d = (dR(2,1)*R(1,1)-R(2,1)*dR(1,1))/R(1,1)^2;
    dF3d = (dR(3,2)*R(3,3)-R(3,2)*dR(3,3))/R(3,3)^2;
    dF4dF5 = 1/(2*sqrt(F5));
    dF5d = 2*R(1,1)*dR(1,1)+2*R(2,1)*dR(2,1);
    dF4d = dF4dF5*dF5d;
    dF2d = (-dR(3,1)*F4+R(3,1)*dF4d)/F5;
    dRid = [dAlphadF1*dF1d;dBetadF2*dF2d;dGammadF3*dF3d];
end