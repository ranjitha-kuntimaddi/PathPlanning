function plot_coord_sys(obj, axis_len, index)

    % Function to plot a coordinate system using an element
    % For internal use only

    % get rotmat
    [rotmat, state1] = obj.get_rotmat(index);
    [vector, state2] = obj.get_vector(index);
    
    % check if get_rotmat() and get_vector were successful
    if ~(state1 && state2)
        return;
    end % check if get_rotmat() and get_vector were successful
       
    % correction of the axis of the coordinate system
    % x-axis
    rotmat(:,1) = rotmat(:,1) / norm(rotmat(:,1)) * axis_len;
    % y-axis
    rotmat(:,2) = rotmat(:,2) / norm(rotmat(:,2)) * axis_len;
    % z-axis
    rotmat(:,3) = rotmat(:,3) / norm(rotmat(:,3)) * axis_len;        

    % plot x axis vector
    quiver3(vector(1), vector(2), vector(3), ...
        rotmat(1,1), rotmat(2,1), rotmat(3,1), ...
        'r', 'LineWidth', 2);
    % plot y axis vector
    quiver3(vector(1), vector(2), vector(3), ...
        rotmat(1,2), rotmat(2,2), rotmat(3,2), ...
        'g', 'LineWidth', 2);
    % plot z axis vector
    quiver3(vector(1), vector(2), vector(3), ...
        rotmat(1,3), rotmat(2,3), rotmat(3,3), ...
        'b', 'LineWidth', 2);

end % plot_coord_sys()

