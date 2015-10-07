function [frame, state] = get_frame(obj, index)

    % Returns the frame of an element of "track"
    
    % check if index is valid
    state = valid_index(obj, index);

    % get frame
    if state
        frame = obj.track(index).get_frame();
        return;
    end % get frame

    % function failed
    frame = []; % empty frame

end % get_frame()