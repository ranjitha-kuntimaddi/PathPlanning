% Function name: getEulerAngles
% Function to calculate the Euler Angles of a certain frame
% Input: 
% 		object:         object of cTrack class
% 		index:			Index, which describes the oder of the frames in the path
%                       By the index the frame for which the Euler Angles
%                       will be calculated is defined
% Output:
% 		A:              Euler Angle around z-axis
%       B:              Euler Angle around y-axis
%       C:              Euler Angle around x-axis

function [A,B,C] = getEulerAngles(object,index)
    % get the rotation matrix
    rotmat = object.get_rotmat(index);    

    % calculate the Euler angles
    A = atan2(rotmat(2,1),rotmat(1,1));
    B = asin(rotmat(3,1));
    C = atan2(rotmat(3,2),rotmat(3,3));
    
    % calculate angles from rad to degree
    A = A*180/pi;
    B = -B*180/pi;
    C = C*180/pi;
end % end of getEulerAngles