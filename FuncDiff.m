function [Error, Sum_Error]= FuncDiff(Zstate,CovMatrixInv,Xstate)

[comp] = FuncfP(Zstate,Xstate);
Error = comp-Zstate(:,1);

%%

nRowNum_poses = length(find(Zstate(:,2)==1));

%pause

i = 1;
while i<=nRowNum_poses;
    if Zstate(i,2)==1;
        for j=3:5;
            while Error(i+j)>pi || Error(i+j)<-pi;
                Error(i+j) = wrap(Error(i+j));
            end;
        end;
        i = i+6;
    elseif Zstate(i,2)==2;
%         i = i+2;
    end;
end;

% Error
% pause
%%
Sum_Error = Error'*CovMatrixInv*Error;
