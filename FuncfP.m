function [uvcomp] = FuncfP(Zstate,Xstate)

%index_para=find(Xstate(:,1)==1,1,'first'); % length, width, height

nRowNum = length(Zstate(:,1));

uvcomp = zeros(nRowNum,1);

%
% nRowNum_poses=length(find(Zstate(:,2)==1));

i = 1;
while i<=nRowNum;
    if Zstate(i,2)==1;
        a = find(Xstate(:,1)==-Zstate(i,4));
        b = find(Xstate(:,1)==-Zstate(i,3));
        P1 = Xstate(a(:),2);
        P2 = Xstate(b(:),2);
        R1 = RMatrixYPR(P1(4),P1(5),P1(6));
        R2 = RMatrixYPR(P2(4),P2(5),P2(6));
        dT = R1'*(P2(1:3)-P1(1:3));
        [dPhi(1,1),dPhi(2,1),dPhi(3,1)] = InvMatirxABG(R1'*R2);
        uvcomp(i:i+5) = [dT;dPhi];
        i = i+6;
    else
        %    'something wrong';
    end
end