function R_yBeta = FuncRY(Beta)
    R_yBeta = [cos(Beta) 0 sin(Beta);
        0 1 0; 
        -sin(Beta) 0 cos(Beta)];
end