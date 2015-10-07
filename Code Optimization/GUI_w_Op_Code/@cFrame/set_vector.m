function [state] = set_vector(obj, vector)

    % Set the vector in property 'vector' of class cFrame.

    % get size of vector
    [rows cols] = size(vector);     % number of rows and columns
    
    % check size of parameter vector
    if ((rows == 1 ) && (cols == 3))
        warning('Parameter "vector" was manipulated by function set_vector()');
        % transpose vector from 1x3 to 3x1
        vector = vector';  
    elseif ~((rows == 3 ) && (cols == 1))
        warning('Parameter "vector" has to be a 3x1 vector');
        state = false;              % function failed
        return;
    end % check size of parameter vector
    
    % check for infinit values or NaN
    if (max(isinf(vector')))
        warning('Parameter "vector" contains infinite element(s)');
        state = false;              % function failed
        return;
    end % check for infinite values
    
    % check for infinit values or NaN
    if (max(isnan(vector')))
       warning('Parameter "vector" contains NaN element(s)');
       state = false;               % function failed
       return;
    end % check for NaN
    
    % copy parameter vector to class property vector
    obj.vector = vector;
    state = true;       % function successful

end % set_vector()

