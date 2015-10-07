% Function name: calcNormVect
% Function to calculate a rotation matix out of three points.
%	- Z-Axis will be in direction from P1 to P2,
%	- X-Axis will also be in the plane of P1P2P3
%	- demo_rot is a rotational matrix of a demonstrated point close to the	
% 	  crossing point as reference to evaluate the direction of the resulting z-axis
%   - X Axis in direction of P3, in this case in direction of the path

function [ rot ] = calcNormVect( P1, P2, P3, rot_ref)

% Three Points to fit plane
P1_P2 = P2-P1;
P2_P3 = P3-P2;

% Z Axis through P1 and P2
Z = P1_P2/norm(P1_P2);

% if the angle between calculated Z-Axis and Z-Axis of close Points is
% more that 45° it is assumed that it points in the opposite direction
% and is therefore turned around 180°.
% !! Works only if demostrated z-Axis orientation resembles the surface normal

if ( norm(Z-rot_ref(:,3)) > sqrt(1.5) )
    Z = -Z;
    Y = cross(P2_P3,P1_P2);    
else
    Y = cross(P1_P2,P2_P3);        
end

Y = Y/norm(Y);
X = cross(Y,Z);
rot = [X,Y,Z];

end % end of calcNormVect

