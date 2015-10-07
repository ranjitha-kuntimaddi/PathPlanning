function [A, B, C, state] = get_rotmat_angles(obj, index)

    % Returns the zyx-euler angles of the rotation matirx
    
    % check if index is valid
    state = valid_index(obj, index);
    if (state == 0)
        A = [];
        B = [];
        C = [];
        return;
    end
    
    % get rotmat
    rotmat = obj.track(index).get_rotmat();
    
    % calculate angles
    A = atan2(rotmat(2,1),rotmat(1,1));
    B = asin(rotmat(3,1));
    C = atan2(rotmat(3,2),rotmat(3,3));
    
    % calculate angles from rad to degree
    A = A*180/pi;
    B = B*180/pi;
    C = C*180/pi;
    
    % minimum rotation correction of the calculated angles
    % minimizes the sum of the absolute values of the angles A, B and C
    
    % correction A
    if (A < 0)
        A2 = A + 180;
    else
        A2 = A - 180;
    end % correction A
    
    % correction B
    if (B < 0)
        B2 = -180 - B;
    else
        B2 = 180 - B;
    end % correction B
    
    % correction C
    if (C < 0)
        C2 = C + 180;
    else
        C2 = C - 180;
    end % correction C
    
    % compare angles
    if ((abs(A)+abs(B)+abs(C)) > (abs(A2)+abs(B2)+abs(C2)))
        % angle set 2 has smaller absolute value sum than set 1
        A = A2;
        B = B2;
        C = C2;
    end % compare angles
    
end % get_rotmat_angles()