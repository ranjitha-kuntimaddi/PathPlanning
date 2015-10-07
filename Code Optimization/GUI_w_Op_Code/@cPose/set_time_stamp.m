function [state] = set_time_stamp(obj, tstamp)

    % Set the property 'timestamp' in class cPose.
    
    % get size of tstamp
    [rows cols] = size(tstamp);     % number of rows and columns
    
    % check size of parameter tstamp
    if ~((rows == 1 ) && (cols == 1))
        warning('Parameter "tstamp" must be a scalar');
        state = 0;      % function failed
        return;
    end % check size of parameter tstamp

    % check if tstamp is valid
    if ((tstamp >= 0) || (tstamp == -1))
       % tstamp is valid, set timestamp
       obj.timestamp = tstamp;  % set time stamp
       state = 1;       % function successful
    else
        % tstamp is invalid
        warning('Parameter "tstamp" has to be >= 0 or -1');
        state = 0;       % function failed
    end

end % set_time_stamp()

