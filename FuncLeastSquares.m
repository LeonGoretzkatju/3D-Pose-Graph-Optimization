function [Xstate,Reason,Info,E] = FuncLeastSquares(Zstate,CovMatrixInv,Xstate)

%% Initial Error
[Error, Sum_Error]= FuncDiff(Zstate,CovMatrixInv,Xstate);
fprintf('Initial Chi^2 is %.8f\n', Sum_Error);

Sum_Delta = 22;
% MaxIter = 0;
MaxIter = 87;
%MinError = 1e-12;
MinError = 0;
% MinError = -1;
MinDelta = 1e-12;

Iter = 0;
while Sum_Error>MinError && Sum_Delta>MinDelta && Iter<=MaxIter;
    [Jacobian] = FuncJacobian(Zstate,Xstate);
    [Delta,Sum_Delta] = FuncDelta(Jacobian,Error,CovMatrixInv);
    
%     spy(Jacobian)
%     pause
%     size(Jacobian)
%     size(Delta)
%     size(Xstate)
%     
%     pause
    
    [Xstate] = FuncUpdate(Xstate,Delta);
    [Error, Sum_Error]= FuncDiff(Zstate,CovMatrixInv,Xstate);
    Iter = Iter+1;
    %Error
    fprintf('Iterations %d Chi^2 %.8f\n', Iter,Sum_Error);    
end;

if Sum_Error<MinError;
    Reason = 1;
elseif Sum_Delta<MinDelta;
    Reason = 2;
elseif Iter>MaxIter;
    Reason = 3;
else
    Reason = 4;
end;

% Info = sparse([]);
% if Iter>0;
    [Jacobian] = FuncJacobian(Zstate,Xstate);
    Info = Jacobian'*CovMatrixInv*Jacobian;
    E = -Jacobian'*CovMatrixInv*Error;
% end;