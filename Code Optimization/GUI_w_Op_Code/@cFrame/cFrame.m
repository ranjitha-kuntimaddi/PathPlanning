% Class cFrame
 
% Version 1.3
%

classdef cFrame < handle % (handle class)
       
    % Homogeneous matrix (frame)
    %
    %         | A11     A12     A13     Px |
    %         |                            |
    %         | A21     A22     A23     Py |
    % frame = |                            |
    %         | A31     A32     A33     Pz |
    %         |                            |
    %         |  0       0       0       V |
    %
    % A11 to A33 is a 3x3 rotation matrix (default: unity matrix).
    % Px, Py, Pz is a vector. This vector could be a position vector
    % or a free vector. This depends on 'V'. By default this vector is
    % a zero vector (P = (0 0 0)').
    % V indicates the kind of vector:
    % V = 0: the vector P is a free vector.
    % V = 1: the vector P points to a position in the used coorinate
    % system.
    
    properties % No property attributes
        
        % Rotation matrix A
        rotmat = eye(3);
        % Position vector P
        vector = [0 0 0]';
        % Indikator V
        indicator = 1;
               
    end % properties
    
    methods % No method attributes
        
        % External defined functions. You will find the code in the same 
        % folder as cFrame.m. The folder name has to be the name of the
        % class with a @ in front of it (foldername = @cFrame).
        
        % Get frame:
        [frame] = get_frame(obj);
        
        % Get rotation matrix:
        [rotmat] = get_rotmat(obj);
        
        % Get position vector:
        [vector] = get_vector(obj);
        
        % Get indicator:
        % [indicator] = get_indicator(obj);
        
        % Set frame:
        [state] = set_frame(obj, frame);
        
        % Set rotation matrix:
        [state] = set_rotmat(obj, rotmat);
        
        % Set position vector:
        [state] = set_vector(obj, vector);
        
        % Set indicator:
        % [state] = set_indicator(obj, indicator);
               
    end % methods
    
end % class frame

