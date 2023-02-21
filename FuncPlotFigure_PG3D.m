function [Pose] = FuncPlotFigure_PG3D(GMap)

X = GMap.st;

Pose = [];
PID = [];

nRowNum_poses = length(find(X(:,1)<=0));

i = 1;
while i<=nRowNum_poses;
    PID = [PID;X(i,1)];
	Pose = [Pose;X(i:i+5,2)'];
	i = i+6;
end;

i=i;
% X=X
% length_estimate=X(i,2)
% width_estimate=X(i+1,2)
% height_estimate=X(i+2,2)


%%
[B,IX] = sort(PID);
Pose = Pose(IX,:);

Pose = [B,Pose]

%%

figure(10)
hold on;
for k=1:size(Pose,1)
    if Pose(k,1)<-1000
plot3(Pose(k,2),Pose(k,3),Pose(k,4),'ro');
    else
        plot3(Pose(k,2),Pose(k,3),Pose(k,4),'bx');
    end
end
        
axis equal;
xlabel('x')
ylabel('y')
zlabel('z')

grid on