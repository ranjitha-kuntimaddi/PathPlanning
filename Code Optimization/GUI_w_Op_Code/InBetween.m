% Function name: InBetween
% Function to check if x,y,z Coordinates of P2 are between x,y,z coordinates
% of P1 and P3
%
% Input:
%		P1:			First point
%		P2:			Point which is checked
%		P3:			Last point
% Output:
%		between: 

function [ between ] = InBetween( P1, P2, P3 )

between = 0;

% check if X-Coordinate is between the two supporting line-points
between = (P1(3)>P3(3) && (P3(3)<P2(3))&&(P2(3)<P1(3))) || (P1(3)<P3(3) && (P3(3)>P2(3)) && (P2(3)>P1(3)) );   
% check if Y-Coordinate is between the two supporting line-points
between = (between && ( (P1(2)>P3(2) && (P3(2)<P2(2))&&(P2(2)<P1(2))) || (P1(2)<P3(2) && (P3(2)>P2(2)) && (P2(2)>P1(2)) )));
% check if Z-Coordinate is between the two supporting line-points
between = (between && ( (P1(3)>P3(3) && (P3(3)<P2(3))&&(P2(3)<P1(3))) || (P1(3)<P3(3) && (P3(3)>P2(3)) && (P2(3)>P1(3)) )));

end % end of InBetween

