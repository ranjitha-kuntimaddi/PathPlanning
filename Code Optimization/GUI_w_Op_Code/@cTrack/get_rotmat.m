function [rotmat, state] = get_rotmat(obj, index)

    % Returns the rotation matrix of an element of "track"

    % check if index is valid
    state = valid_index(obj, index);

    % get rotation matrix
    if state
        rotmat = obj.track(index).get_rotmat();
        return;
    end % get rotation matrix

    % function failed
    rotmat = [];    % empty frame

end % get_rotmat()

