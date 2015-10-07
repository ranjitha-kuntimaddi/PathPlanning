function [state] = set_frame(obj, frame, index)

    % Sets the frame of an element of "track"

    % check if index is valid
    state = valid_index(obj, index);

    % set frame
    if state
        state = obj.track(index).set_frame(frame);
        return;
    end % set frame

    % function failed
    
end % set_frame()

