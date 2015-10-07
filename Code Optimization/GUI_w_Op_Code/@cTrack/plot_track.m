function plot_track(obj, plot_coord, coord_dist, varargin)

    % Plot the stored "track" of the object
    
    % check number of arguments
    error(nargchk(3, inf, nargin));
    
    % check parameter plot_coord
    if((plot_coord ~= 0) && (plot_coord ~= 1))
        error('Parameter "plot_coord" has to be 0 or 1');
    end % check parameter plot_coord
    
    % check parameter coord_dist
    if (coord_dist < 0)
        error('Parameter "coord_dist" has to be >= 0');
    end % check parameter coord_dist
    
    % check if there are data to plot
    len = length(obj.track);
    if (len == 0)
        % nothing to plot
        return;
    end % check if there are data to plot
     
    % get vectors form property track
    hold_was_on = ishold();
    hold off;
    xyzVector = [obj.track(:).vector];
    x = xyzVector(1,:);
    y = xyzVector(2,:);
    z = xyzVector(3,:);
    
    % plot track
    hold on;
    plot3(x, y, z, varargin{:});            % plot track
    plot3(x(1), y(1), z(1), '*g');          % plot first pose as green star
    plot3(x(len), y(len), z(len), '*r');    % plot last pose as red star
    axis square;
    
    % calculate max scope range of the plot
    x_length = max(x) - min(x);
    y_length = max(y) - min(y);
    z_length = max(z) - min(z);
    max_len = max([x_length y_length z_length]);

    % avoid that the calculated scope range is zero for 1 or more axis
    if (max_len ~= 0)
        % calculate length of coordinate system vectors
        coord_axis_len = 0.2 * max_len;
    else
        % set coordinate vector length to fix value
        coord_axis_len = 0.4;
    end % avoid that the calculated scope range is zero for 1 or more axis

    % adapte axis of the plot
    axis([(min(x) - coord_axis_len) (max(x) + coord_axis_len) ...
        (min(y) - coord_axis_len) (max(y) + coord_axis_len) ...
        (min(z) - coord_axis_len) (max(z) + coord_axis_len)]);
    
    % plot coordinate systems if demanded
    if (plot_coord == 1)
    
        % compare index for distance calculation
        last_index = 1;
        
        % plot first coordinate system
        obj.plot_coord_sys(coord_axis_len, 1);
        if (len == 1)
            % only one point to plot
            return;
        end
        
        % plot single coordinate systems
        for i = 2:len
            
            % get distance between two points
            dist = obj.get_distance(last_index, i);
            
            if (dist >= (coord_axis_len * coord_dist))
                % update index of last coordinate system
                last_index = i;
                % plot coordinate system
                obj.plot_coord_sys(coord_axis_len, i);
            end
            
        end % plot single coordinate systems
        
    end % plot coordinate system
    
    % restore hold state
    if ~(hold_was_on)
        hold off;
    end        

end % plot_track()

