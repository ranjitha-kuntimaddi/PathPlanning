function [vector, state] = get_vector(obj, index)

    % Returns the vector of an element of "track"

    % check if index is valid
    state = valid_index(obj, index);

    % get vector
    if state
        vector = obj.track(index).get_vector();
        return;
    end % get vector

    % function failed
    vector = [];    % empty frame
    
end % get_vector()
