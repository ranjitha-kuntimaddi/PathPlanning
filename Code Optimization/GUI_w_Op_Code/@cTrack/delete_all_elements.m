function delete_all_elements(obj)

    % Function to delete all elements in property "track".
    
    % check parameter
    len = length(obj.track);
    
    % check if there are any elements in property track
    if (len ~= 0)
        % delete all referenced object instances of class cPose
        obj.track(:).delete();
    end % check if there are any elements in property track
    
    % delete all elements (references) in property "track"
    obj.track = [];  
 
end % delete_all_elements()
