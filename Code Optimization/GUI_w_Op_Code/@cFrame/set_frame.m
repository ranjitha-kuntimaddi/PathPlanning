function [state] = set_frame(obj, frame)

    % Set the property frame of class cFrame.

    % get size of frame
    [rows cols] = size(frame);      % number of rows and columns
    
    % Copy of original frame as backup
    orig_frame = obj.get_frame();

    % check size of parameter frame
    if ~((rows == 4 ) && (cols == 4))
        warning('Parameter "frame" has to be a 4x4 matrix');
        state = 0;      % function failed
        return;
    end % check size of parameter frame
    
    % check kind of vector
    if ~((frame(4,4) == 0) || (frame(4,4) == 1))
        warning('The kind of vector has to be 0 or 1');
        state = 0;      % function failed
        return;
    end % check kind of vector
    
    % set properties in class object
    % set indicator
    obj.indicator = frame(4,4);
    
    % set vector
    state_1 = obj.set_vector(frame((1:3),4));
    
    % set rotation matrix
    state_2 = obj.set_rotmat(frame(1:3,1:3));
    
    if ~(state_1 && state_2)
        % One or more functions failed
        % Restore frame and return
        obj.rotmat = orig_frame((1:3),(1:3));
        obj.vector = orig_frame((1:3),4);
        obj.indicator = orig_frame(4,4);
        state = 0;      % function failed
        return;
    end
    
    state = 1;          % function successful
    
end % set_frame()

