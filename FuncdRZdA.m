function dRZdA = FuncdRZdA(Alpha)
    dRZdA = [-sin(Alpha) -cos(Alpha) 0;
        cos(Alpha) -sin(Alpha) 0;
        0 0 1];
end