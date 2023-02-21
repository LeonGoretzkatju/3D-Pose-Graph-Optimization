function [Delta,Sum_Delta] = FuncDelta(Jacobian,Error,CovMatrixInv)
%Jacobian
Info = Jacobian'*CovMatrixInv*Jacobian;
%check_Info=eig(Info)
E = -Jacobian'*CovMatrixInv*Error;
%pause

Delta = Info\E;
Sum_Delta = Delta'*Delta;
end