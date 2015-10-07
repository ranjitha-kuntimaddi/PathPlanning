function animate_track(obj, varargin)

    % Animates a motion along the track
    
    % check if there are data to animate
    len = length(obj.track);
    if (len == 0)
        % nothing to plot
        return;
    end % check if there are data to animate
        
    % get data from object
    vector_array(3,len) = 0;
    rotmat_array(3,3,len) = 0;
    time_array(1,len) = 0;
    for i = 1:len
        vector_array(:,i) = obj.track(i).get_vector();
        rotmat_array(:,:,i) = obj.track(i).get_rotmat();
        % get time stamp and adapt value from milliseconds to seconds
        time_array(1,i) = 0.001 * obj.track(i).get_time_stamp();
    end
    
    % plot track
    hold_was_on = ishold();
    hold off;
    
    plot3(vector_array(1,:), vector_array(2,:), vector_array(3,:), ...
        varargin{:});
    
    hold on;
    
    % start and endpoint
    plot3(vector_array(1,1), vector_array(2,1), ...
        vector_array(3,1), '*g');
    plot3(vector_array(1,len), vector_array(2,len), ...
        vector_array(3,len), '*r');
    
    % Calculate plot scope
    x_min = min(vector_array(1,:));
    x_max = max(vector_array(1,:));
    y_min = min(vector_array(2,:));
    y_max = max(vector_array(2,:));
    z_min = min(vector_array(3,:));
    z_max = max(vector_array(3,:));
    
    % calculate max scope range of the plot
    x_length = x_max - x_min;
    y_length = y_max - y_min;
    z_length = z_max - z_min;
    max_len = max([x_length y_length z_length]);
    
    % avoid that the calculated scope range is zero for 1 or more axis
    if (max_len ~= 0)
        % calculate length of coordinate system vectors
        coord_axis_len = 0.2 * max_len;
    else
        % set coordinate vector length to fix value
        coord_axis_len = 0.4;
    end % avoid that the calculated scope range is zero for 1 or more axis
    
    % Adapt axis
    axis equal;
    axis([(x_min - coord_axis_len) (x_max + coord_axis_len) ...
        (y_min - coord_axis_len) (y_max + coord_axis_len) ...
        (z_min - coord_axis_len) (z_max + coord_axis_len)]);
    
    % Animation
    for i = 1:len
        
        % Create vectors for coodrinate system. Each axis has one vector.
        vector = vector_array(:,i);
        rotmat = rotmat_array(:,:,i);
        
        % correction of the axis of the coordinate system
        % x-axis
        rotmat(:,1) = rotmat(:,1) / norm(rotmat(:,1)) * coord_axis_len;
        % y-axis
        rotmat(:,2) = rotmat(:,2) / norm(rotmat(:,2)) * coord_axis_len;
        % z-axis
        rotmat(:,3) = rotmat(:,3) / norm(rotmat(:,3)) * coord_axis_len;        

        % plot x axis vector
        p1 = quiver3(vector(1,1), vector(2,1), vector(3,1), ...
            rotmat(1,1), rotmat(2,1), rotmat(3,1), ...
            'r', 'LineWidth', 2);
        % plot y axis vector
        p2 = quiver3(vector(1,1), vector(2,1), vector(3,1), ...
            rotmat(1,2), rotmat(2,2), rotmat(3,2), ...
            'g', 'LineWidth', 2);
        % plot z axis vector
        p3 = quiver3(vector(1,1), vector(2,1), vector(3,1), ...
            rotmat(1,3), rotmat(2,3), rotmat(3,3), ...
            'b', 'LineWidth', 2);      

        % The following part does not work for i == len
        if(i < len)
            % wait delta_t
            delta_t = time_array(i+1) - time_array(i);
            pause(delta_t);
            
            % delete coordinate system from plot
            delete(p1);
            delete(p2);
            delete(p3); 
        else
            % do nothing
        end

    end % Animation
    
    % Adapt axis again
    axis([(x_min - coord_axis_len) (x_max + coord_axis_len) ...
        (y_min - coord_axis_len) (y_max + coord_axis_len) ...
        (z_min - coord_axis_len) (z_max + coord_axis_len)]);
    
    % restore hold state
    if ~(hold_was_on)
        hold off;
    end        
    
end % animate_track()

