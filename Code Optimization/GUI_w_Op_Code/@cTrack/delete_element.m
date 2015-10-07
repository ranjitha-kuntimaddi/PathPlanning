function [state] = delete_element(obj, index)

    % Deletes an element in the track array
    
    % check if index is valid
    if ~(valid_index(obj, index))
        state = 0;  % function failed
        return;
    end % check if index is valid
    
    % delete referenced object
    obj.track(index).delete();
    
    % delete element (reference) in property "track"
% % %     obj.track(index) = [];
% % %     %%%neu: 
    obj.track = obj.track([1:(index-1) (index+1):end]);

    state = 1;      % function successful
    
end % delete_element()

