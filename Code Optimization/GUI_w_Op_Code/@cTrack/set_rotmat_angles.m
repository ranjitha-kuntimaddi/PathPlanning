function [state] = set_rotmat_angles(obj, A, B, C, index)

    % Sets the rotation matrix by using zyx-euler angles

    % check if index is valid
    state = valid_index(obj, index);
    if (state == 0)
        return;
    end
    
    % calculate angles form degree into rad
    A = A/180*pi;   % angle around z-axis
    B = B/180*pi;   % angle around y-axis
    C = C/180*pi;   % angle around x-axis
    
    a11 = cos(A)*cos(B);
    a12 = -sin(A)*cos(C)-cos(A)*sin(B)*sin(C);
    a13 = sin(A)*sin(C)-cos(A)*sin(B)*cos(C);
    a21 = sin(A)*cos(B);
    a22 = cos(A)*cos(C)-sin(A)*sin(B)*sin(C);
    a23 = -cos(A)*sin(C)-sin(A)*sin(B)*cos(C);
    a31 = sin(B);
    a32 = cos(B)*sin(C);
    a33 = cos(B)*cos(C);
            
    % set rotation matrix
    state = obj.track(index).set_rotmat([a11 a12 a13; ...
        a21 a22 a23; a31 a32 a33]);

end % set_rotmat_angles()

