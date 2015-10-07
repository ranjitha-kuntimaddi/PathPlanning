% Class cPose

% Version 1.5
%

classdef cPose < cFrame
    
    % This class contains information of a pose in a 3D environment.
    % Position and orientation are described by a homogeneous matrix
    % (frame). As additional information a time stamp is stored, so it is
    % possible to sort a number of poses into an order.
    % % The class contains also the speed at the stored point.
       
    properties % No property attributes
        
        % Timestamp of the pose
        % If there is no time information the value is -1 (default).
        timestamp = -1;
        
        % Speed at the given point
        % speed = zeros(3,1);
        
    end % properties
    
    methods % No method attributes
        
        % Constructor for objects of class
        % Constructor to creat objects of class cPose. By default one
        % object will be created. When using parameter n, an array of
        % objects will be created.
        %
        % Parameter n: number of object elements that should be created.
        % Must be greater 0
        %
        % Return value obj: object handle
        function obj = cPose(n, varargin)
            
            if (nargin == 0)
                % use default constructor
            elseif (nargin == 1)
                % check parameter
                if(n == 0)
                    error('Argument n has to be >0');
                end
                % create array of objects
                obj(n) = cPose;
            else 
                % too much arguments
                error('Constructor has 0 or 1 argument');
            end
            
            return;
            
        end % cPose()
        
        % External defined functions. You will find the code in the same 
        % folder as cPose.m. The folder name has to be the name of the
        % class with a @ in front of it (foldername = @cPose).
        
        % Get time stamp:
        [tstamp] = get_time_stamp(obj);
                     
        % Set time stamp:
        [state] = set_time_stamp(obj, tstamp);
        
    end % method
    
end % cPose

