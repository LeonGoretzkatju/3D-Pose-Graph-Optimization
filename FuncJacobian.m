function [Jacobian] = FuncJacobian(Zstate,Xstate)
    nRowNum = length(Zstate(:,1));
ID1 = [];
ID2 = [];
Val = [];

i = 1;
while i<=nRowNum;
    if Zstate(i,2)==1;
        a = find(Xstate(:,1)==-Zstate(i,4));
        b = find(Xstate(:,1)==-Zstate(i,3));
        P1 = Xstate(a(:),2);
        P2 = Xstate(b(:),2);
        
        %%
        Alpha = P1(4);
        Beta = P1(5);
        Gamma = P1(6);
        
        RZ = FuncRZ(Alpha);
        RY = FuncRY(Beta);
        RX = FuncRX(Gamma);
        R = FuncR(RZ,RY,RX);
        t = P1(1:3);
        dRZdA = FuncdRZdA(Alpha);
        dRYdB = FuncdRYdB(Beta);
        dRXdG = FuncdRXdG(Gamma);
        dRdA = FuncR(dRZdA,RY,RX);
        dRdB = FuncR(RZ,dRYdB,RX);
        dRdG = FuncR(RZ,RY,dRXdG);
        %%        
        t2 = P2(1:3);
        Alpha2 = P2(4);
        Beta2 = P2(5);
        Gamma2 = P2(6);
        %%
        RZ2 = FuncRZ(Alpha2);
        RY2 = FuncRY(Beta2);
        RX2 = FuncRX(Gamma2);
        R2 = FuncR(RZ2,RY2,RX2);
        
        Ri = R'*R2;
        
        dRZ2dA2 = FuncdRZdA(Alpha2);
        dRY2dB2 = FuncdRYdB(Beta2);
        dRX2dG2 = FuncdRXdG(Gamma2);
        dR2dA2 = FuncR(dRZ2dA2,RY2,RX2);
        dR2dB2 = FuncR(RZ2,dRY2dB2,RX2);
        dR2dG2 = FuncR(RZ2,RY2,dRX2dG2);
        %%
        dRidA2 = R'*dR2dA2;
        dRidB2 = R'*dR2dB2;
        dRidG2 = R'*dR2dG2;
        dRidA = dRdA'*R2;
        dRidB = dRdB'*R2;
        dRidG = dRdG'*R2;
        %%
        ddA2 = FuncdRi(dRidA2,Ri);
        ddB2 = FuncdRi(dRidB2,Ri);
        ddG2 = FuncdRi(dRidG2,Ri);
        ddA = FuncdRi(dRidA,Ri);
        ddB = FuncdRi(dRidB,Ri);
        ddG = FuncdRi(dRidG,Ri);

        R_T = R';
        
        %% add the values in Jacobian
        ID1 = [ID1;i;i+1;i+2;i;i+1;i+2;i;i+1;i+2;i;i+1;i+2;i;i+1;i+2;i;i+1;i+2;i;i+1;i+2;i;i+1;i+2;i;i+1;i+2;i+3;i+4;i+5;i+3;i+4;i+5;i+3;i+4;i+5;i+3;i+4;i+5;i+3;i+4;i+5;i+3;i+4;i+5];
        ID2 = [ID2;a(1);a(1);a(1);a(2);a(2);a(2);a(3);a(3);a(3);a(4);a(4);a(4);a(5);a(5);a(5);a(6);a(6);a(6);b(1);b(1);b(1);b(2);b(2);b(2);b(3);b(3);b(3);a(4);a(4);a(4);a(5);a(5);a(5);a(6);a(6);a(6);b(4);b(4);b(4);b(5);b(5);b(5);b(6);b(6);b(6)];
        Val = [Val;-R_T(:,1);-R_T(:,2);-R_T(:,3);dRdA'*(t2-t);dRdB'*(t2-t);dRdG'*(t2-t);R_T(:,1);R_T(:,2);R_T(:,3);ddA;ddB;ddG;ddA2;ddB2;ddG2];
        
        i = i+6;
    elseif Zstate(i,2)==2
        i = i+3;      
        
      
        
    elseif Zstate(i,2)==0 % direct measurement of length, width and/or height
        p=find(Xstate(:,1)==1);
        %pause
        if Zstate(i,4)==-1
            ID1 = [ID1;  i];
            ID2 = [ID2;  p(1)];
            Val = [Val;  1];
        elseif Zstate(i,4)==-2
            ID1 = [ID1;  i];
            ID2 = [ID2;  p(2)];
            Val = [Val;  1];
        elseif Zstate(i,4)==-3
            ID1 = [ID1;  i];
            ID2 = [ID2;  p(3)];
            Val = [Val;  1];
        end
        i=i+1;
    end
end

Jacobian = sparse(ID1,ID2,Val);
Jacobian = Jacobian(:,7:end);
end