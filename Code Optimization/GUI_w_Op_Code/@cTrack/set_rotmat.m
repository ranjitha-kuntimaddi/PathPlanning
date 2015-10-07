function [state] = set_rotmat(obj, rotmat, index)

    % Sets the rotation matrix of an element of "track"

    % check if index is valid
    state = valid_index(obj, index);
    
    % set rotation matrix
    if state
        state = obj.track(index).set_rotmat(rotmat);
        return;
    end % set rotation matrix

    % function failed
    
end % set_rotmat()

