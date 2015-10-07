function [state] = set_vector(obj, vector, index)

    % Sets the vector of an element of "track"

    % check if index is valid
    state = valid_index(obj, index);

    % set vector
    if state
        state = obj.track(index).set_vector(vector);
        return;
    end % set vector

    % function failed

end % set_vector()

