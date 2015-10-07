function [state] = set_time_stamp(obj, tstamp, index)

    % Sets the time stamp of an element of "track"

    % check if index is valid
    state = valid_index(obj, index);

    % set vector
    if state
        state = obj.track(index).set_time_stamp(tstamp);
        return;
    end % set vector

    % function failed

end % set_time_stamp()

