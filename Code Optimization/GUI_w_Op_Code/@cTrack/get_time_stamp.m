function [tstamp, state] = get_time_stamp(obj, index)

    % Returns the time stamp of an element of "track"

    % check if index is valid
    state = valid_index(obj, index);

    % get time stamp
    if state
        tstamp = obj.track(index).get_time_stamp();
        return;
    end % get time stamp

    % function failed
    tstamp = [];    % empty frame
    
end % get_time_stamp()

