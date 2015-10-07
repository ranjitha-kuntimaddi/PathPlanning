function [frame] = get_frame(obj)
    
    % Returns the homogeneous matrix (frame) of class cFrame.

    % Create and return frame
    frame = obj.rotmat;
    frame = [frame; [0 0 0]];
    frame = [frame [obj.vector; obj.indicator]];

end % get_frame()

