function [state] = valid_index(obj, index)

    % Function to check, if the given index is valid
    % 1 <= index <= len
    
    % index less than 1
    if (index < 1)
        warning('Parameter "index" must be >= 1');
        state = 0;
        return;
    end % index less than 1
    
    % index is no integer
    if ((round(index)-index) ~= 0)
        warning('Parameter "index" must be positiv integer');
        state = 0;
        return;
    end % index is no integer
    
    % get property length
    len = length(obj.track);
    
    % is len = 0
    if (len == 0)
        state = 0;
        return;
    end % is len = 0
    
    % index greater length of track
    if (index > len)
        state = 0;
        return;
    end   

    state = 1;      % function successful

end % valid_index()