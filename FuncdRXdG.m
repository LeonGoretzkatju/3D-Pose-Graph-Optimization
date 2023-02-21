function dRXdG = FuncdRXdG(Gamma)
    dRXdG = [1 0 0;
        0 -sin(Gamma) -cos(Gamma);
        0 cos(Gamma) -sin(Gamma)];
end