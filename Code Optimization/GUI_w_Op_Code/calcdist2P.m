% Function name: calcdist2P
% Function to calculate the distance between two points
% Input:
%       ps:             Startpoint of calculation
%       pe:             Endpoint of calculation
% Output:
%       distance:       Distance between ps and pe

function [distance] = calcdist2P(ps,pe)

vx       = ps(1) - pe(1);               %Difference x
vy       = ps(2) - pe(2);               %Difference y
vz       = ps(3) - pe(3);               %Difference z
square   = (vx*vx) + (vy*vy) + (vz*vz); %Square of each part added

distance = sqrt(square);                %Squareroot gives the distance

end % end of calcdist2P