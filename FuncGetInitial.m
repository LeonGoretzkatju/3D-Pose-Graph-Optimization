function [Xstate] = FuncGetInitial(Zstate) % initialization state

XstateP = []; % first column, -n, (pose n) second column, state value
a = find(Zstate(:,2)==1);
%b = find(Zstate(:,2)==2);
XstateP(1:6,1:2) = 0;
XstateP(1:6,1) = -Zstate(a(1),4);
i = 1;
% n = 1;
while i<=length(a);
    n = Zstate(a(i),3);
    check_n=find(XstateP(:,1)==-n);
    if size(check_n,1)==0
    dT = Zstate(a(i:i+2),1);
    R12=RMatrixYPR(Zstate(a(i+3),1),Zstate(a(i+4),1),Zstate(a(i+5),1));
    index_1=find(XstateP(:,1)==-Zstate(a(i),4),1,'first');
    T1=XstateP(index_1:index_1+2,2);
%     XstateP(index_1+3,1)
%     XstateP(index_1+4,1)
%     XstateP(index_1+5,1)
    R1=RMatrixYPR(XstateP(index_1+3,2),XstateP(index_1+4,2),XstateP(index_1+5,2));
    T2 = R1*dT+T1;
    [Y2,P2,R2] = InvMatirxABG(R1*R12);
    XstateP = [XstateP;[[-n;-n;-n;-n;-n;-n],[T2;Y2;P2;R2]]];
    end
    i = i+6;
%     n = n+1;
end
Xstate = XstateP;
%pause