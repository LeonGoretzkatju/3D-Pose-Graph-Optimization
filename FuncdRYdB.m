function dRYdB = FuncdRYdB(Beta)
    dRYdB = [-sin(Beta) 0 cos(Beta);
        0 1 0; 
        -cos(Beta) 0 -sin(Beta)];
end