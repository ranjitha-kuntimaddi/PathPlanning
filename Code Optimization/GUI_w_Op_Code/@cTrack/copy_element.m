function [state] = copy_element(dst_obj, dst_index, src_obj, src_index)

    % Function to copy an object instance of class cPose.

    % check if parameter dst_obj is of class cTrack
    if ~(strcmp('cTrack',class(dst_obj)))
        error('Parameter "dst_obj" must be of class "cTrack"');
    end % check if parameter dst_obj is of class
    
    % check if parameter src_obj is of class cTrack
    if ~(strcmp('cTrack',class(src_obj)))
        error('Parameter "src_obj" must be of class "cTrack"');
    end % check if parameter src_obj is of class 
        
    % check destination index
    if ~(valid_index(dst_obj, dst_index))
        state = 0;      % function failed
        return;
    end % check destination index
    
    % check source index
    if ~(valid_index(src_obj, src_index))
        state = 0;      % function failed
        return;
    end % check source index 
    
    % copy data from src_obj to dst_obj
    % copy frame
    frame = src_obj.get_frame(src_index);
    dst_obj.set_frame(frame, dst_index); 
    % copy time stamp
    tstamp = src_obj.get_time_stamp(src_index);
    dst_obj.set_time_stamp(tstamp, dst_index);
    
    state = 1;      % function successful

end % copy_element()

