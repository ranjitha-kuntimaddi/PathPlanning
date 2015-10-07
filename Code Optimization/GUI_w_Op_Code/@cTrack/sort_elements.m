function sort_elements(obj)

    % Sorts all elements in attribute "track" by time stamp
    
    % check if sort is necessary
    if (obj.number_of_elements() < 2)
        return;
    end % check if sort is necessary
    
    [sortedArray, order] = sort([obj.track(:).timestamp]);  
    obj.track = obj.track(order);
    return;

end % sort_elements()

