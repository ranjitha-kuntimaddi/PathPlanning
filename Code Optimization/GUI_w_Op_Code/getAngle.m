function [ angle ] = getAngle( frameA, frameB )
%GETANGLE Summary of this function goes here
%   Detailed explanation goes here

xA = [frameA(1,1)  frameA(1,2)  frameA(1,3)];
xB = [frameB(1,1)  frameB(1,2)  frameB(1,3)];
yA = [frameA(2,1)  frameA(2,2)  frameA(2,3)];
yB = [frameB(2,1)  frameB(2,2)  frameB(2,3)];
zA = [frameA(3,1)  frameA(3,2)  frameA(3,3)];
zB = [frameB(3,1)  frameB(3,2)  frameB(3,3)];

% % % %%%
a = xA + yA + zA;
b = xB + yB + zB;
c = [a(2)*b(3)-b(2)*a(3) -a(1)*b(3)+b(1)*a(3) a(1)*b(2)-b(1)*a(2)];
angle = atan2(norm(c)...
    ,dot(a ,b));
% % % % angle = atan2(norm(cross(a ,b))...
%     ,dot(a ,b));
% % % angle = vrrotvec(xA + yA + zA ,xB + yB + zB);
% % % angle = angle(4);
%tempY = vrrotvec(yA,yB);
%tempZ = vrrotvec(zA,zB);

%angle = [tempX(4) tempY(4) tempZ(4)]';
%angle = sqrt(tempX(4)^2 + tempY(4)^2 + tempZ(4)^2);
%angle = sqrt(tempX(4)*tempX(4) + tempY(4)*tempY(4) + tempZ(4)*tempZ(4));
angle = angle*180/pi;
end

