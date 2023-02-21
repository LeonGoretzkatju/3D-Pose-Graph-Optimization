function R_zAlpha = FuncRZ(Alpha)
    R_zAlpha = [cos(Alpha) -sin(Alpha) 0;
        sin(Alpha) cos(Alpha) 0;
        0 0 1];
end