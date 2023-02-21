function [rel_T12,rel_YPR] = FuncRelative12(T1,YPR1,T2,YPR2)
    R1 = RMatrixYPR(YPR1(1),YPR1(2),YPR1(3));
    R2 = RMatrixYPR(YPR2(1),YPR2(2),YPR2(3));
    rel_T12 = R1'*(T2-T1);
    rel_R12 = R1'*R2;
    [A12,B12,G12] = InvMatirxABG(rel_R12);
    rel_YPR = [A12;B12;G12];
end