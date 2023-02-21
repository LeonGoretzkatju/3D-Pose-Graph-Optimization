for i=1:length(Pose(:,1));
        while Pose(i,4)>pi || Pose(i,4)<-pi;
            Pose(i,4) = wrap(Pose(i,4));
        end;
end;