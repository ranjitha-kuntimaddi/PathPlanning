function [state] = copy_object(dst_obj, src_obj)

    % Copy an object of class cTrack
    
    % check if parameter dst_obj is of class cTrack
    if ~(strcmp('cTrack',class(dst_obj)))
        error('Parameter "dst_obj" must be of class "cTrack"');
    end % check if parameter dst_obj is of class 
    
    % check if parameter src_obj is of class cTrack
    if ~(strcmp('cTrack',class(src_obj)))
        error('Parameter "src_obj" must be of class "cTrack"');
    end % check if parameter src_obj is of class
    
    % delete all elements in destination object
    dst_obj.delete_all_elements();
        
    % get number of elements in source object
    len = src_obj.number_of_elements();

    % check number of elements
    if(len == 0)
        % nothing to copy
        state = 1;
        return;
    end % check number of elements
    
    % create default track and copy data
    dst_obj.track = cPose(len);
    for i = 1:len
        dst_obj.copy_element(i, src_obj, i);
    end
    
    state = 1;
    return;         % function successful

end % copy_object()

