% Class cTrack
%
% Version 1.7
%

classdef cTrack < handle % (handle class)
    
    % Description of the class
    
    properties % No property attributes
        
        % Array with poses
        track = [];
        
    end % properties
     
    methods % No method attributes
        
        % Constructor for objects of class
        % By default an object with no elements inside will be created. By
        % using a file name as first parameter the data from file will be
        % loaded into the object. Otherwise the first parameter could hold
        % a numbers N. Then constructor will create a track consisting
        % of N default cPose elements. Use the last option to create an
        % instance of class cTrack if the track length is known.
        %
        % Parameter vararg: This parameter could have different values
        % "vararg" is a string: "vararg" contains the name of the file that
        % contains data that should be loaded to the object. It must be a
        % file created by the tracker used at the h_da or has to have the
        % same format.
        % "vararg" is a number: "vararg" contains the number of single
        % elements of class cPose that are created in the object. The
        % elements contain default parameter.
        % 
        % Parameter varargin: variable number of input parameters. No real
        % parameter.
        %
        % Return value obj: created class object
        function [obj] = cTrack(vararg, varargin)
            
            % check number of arguments
            if (nargin == 0)
                % use default constructor
            elseif (nargin == 1)
                % check if vararg is string or number
                if (ischar(vararg))
                    % read file and copy data to property
                    read_from_file(obj, vararg);
                else
                    % check number of elements
                    if ((vararg >= 1) && ((round(vararg)-vararg) == 0))
                        % create track with N default elements of cPose
                        obj.track = cPose(vararg);
                    else
                        warning(['Parameter vararg < 1 or no integer, ' ...
                            'default object created']);
                        obj.track = [];
                    end % check number of elements
                end % check if vararg is string or number
            else % (nargin > 1)
                % too much arguments
                error('Constructor has 0 or 1 argument');
            end % check number of arguments
            
            return;
           
        end % cTrack()
        
        
        % External defined functions. You will find the code in the same 
        % folder as cTrack.m. The folder name has to be the name of the
        % class with a @ in front of it (foldername = @cTrack).
        
        % Create a new element with default values
        % The function creates a new element and inserts it inserted in
        % the property "track". The new element contains default values
        % (see files "cPose.m" and "cFrame.m"). With the parameter "index"
        % it is possible to determine the position in the property "track".
        % By default (parameter index is not used) or an index out of reach
        % the created element will be inserted as last element of property
        % "track". If the element could not be created the
        % function returns 0 as index.
        %
        % Parameter obj: object
        % Parameter index: optional, place in property "track" where the
        % object should be created
        %
        % Return value index: index of created object in property "track"
        % 0 if element could not be created
        [index] = new_element(obj, index);
        
        % Copy element
        % The function copies the data of an element of property "track" to
        % another element of property "track". Source and destination
        % object can be the same or different.
        %
        % Parameter dst_obj: destination object where the data should be
        % stored
        % Parameter dst_index: index of destination element in property
        % "track"
        % Parameter src_obj: source object that contains the data to be
        % copied to dst_obj
        % Parameter src_index: index of source element in object src_obj
        %
        % Return value state: 1 if object was copied successful and 0 if
        % function failed
        [state] = copy_element(dst_obj, dst_index, src_obj, src_index);
        
        % Create copy of an object of class cTrack
        % The function copies all elements of an object. The data in the
        % destination object will be identical to the source object. So all
        % former in dst_obj stored date will be lost.
        %
        % Parameter dst_obj: destination object that is filled with data
        % Parameter src_obj: source object that holds the data that should
        % be copied
        %
        % Return value state: 1 if object was copied successful and 0 if
        % function failed
        [state] = copy_object(dst_obj, src_obj);
        
        % Sort data in property "track" in time order
        %
        % Parameter obj: object
        %
        % No return values
        sort_elements(obj);
        
        % Plot the track
        %
        % This function is used to plot the track. The second parameter
        % belong to the coordinate system. If parameter "plot_coord" is 1
        % the coordinate systems (orientation of the track) will be
        % plotted. If the track should be plotted without the coordinate
        % systems "plot_coord" has to be 0.
        % With the third parameter ("coord_dist") it is possible to
        % determine the minimum distance between two plotted coordinate
        % system. The distance is given as multiple of the length of the
        % coordinate system vectors.
        %
        % For the plot itself the function uses plot3(). It is possible to
        % use its parameters, for example to change the line style or the
        % colour of the plot (described in MATLAB help).
        % If you want to use the variable parameter input of plot3()
        % inside the function, attach them after the third parameter.
        %
        % Parameter obj: object
        % Parameter plot_coord: 1 if coordinate systems are plotted and 0
        % if the coordinate systems are not plotted
        % Parameter coord_dist: minimum distance between two plotted
        % coordinate systems (>= 0)
        % Parameter varargin: variable number of input parameters (used for
        % the plot3() parameters)
        %
        % No return value
        plot_track(obj, plot_coord, coord_dist, varargin);
        
        % Animation of the track
        %
        % The function animates the tracked motion on the path. To plot the
        % path the function uses plot3(). It is possible to use its
        % parameters. They are attached after the first parameter ("obj").
        % For details to the plot3() parameters see MATLAB help.
        %
        % Parameter obj: object
        % Parameter varargin: variable number of input parameters (used for
        % the plot3() parameters)
        %
        % No return values
        animate_track(obj, varargin);
        
        % Delete a single object from the property "track"
        %
        % Parameter index: index of the element that should be deleted
        %
        % Return value state: contains 1 if element was deleted and 0 if
        % function failed
        [state] = delete_element(obj, index);
        
        % Delete all objects from the property "track"
        %
        % Parameter obj: object
        %
        % No return values
        delete_all_elements(obj);
        
        % Get the number of elements in property "track"
        %
        % Parameter obj: object
        %
        % Return value number: number of elements in property "track"
        [number] = number_of_elements(obj);
        
        % Read from file
        %
        % The function can read the data form a file created by the 
        % tracker used for this project and store them in the property
        % "track".
        %
        % Parameter obj: object
        % Parameter filename: name of the file plus extention from where
        % the data should be read, for exampe: 'path.csv' or 'test.txt'
        %
        % No return values
        read_from_file(obj, filename);
        
        % Write to file
        %
        % The function writes the data from an object of class cTrack to a
        % file.
        %
        % Parameter obj: object
        % Parameter filename: name of the file plus extention where the
        % data from the object should be stored, for exampe: 'path.csv' or
        % 'test.txt'
        %
        % No return values
        write_to_file(obj, filename);
            
        % Get frame:
        %
        % Parameter obj: object
        % Parameter index: index of element in "track"
        %
        % Return value frame: homogeneous matrix (frame) in indexed
        % element of obj
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [frame, state] = get_frame(obj, index);                   
        
        % Get rotation matrix:
        %
        % Parameter obj: object
        % Parameter index: index of element in "track"
        %
        % Return value rotmat: rotation matrix in indexed element of obj
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [rotmat, state] = get_rotmat(obj, index);
        
        % Get zyx-euler-angles of the rotation matrix
        %
        % This function returns its zyx-euler-angles A, B and C instead of
        % the rotation matrix 
        %
        % Parameter obj: object
        % Parameter index: index of element in "track"
        %
        % Return value A: rotation angle around the z-axis
        % Return value B: rotation angle around the y-axis
        % Return value C: rotation angle around the x-axis
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [A, B, C, state] = get_rotmat_angles(obj, index);

        % Get position vector:
        %
        % Parameter obj: object
        % Parameter index: index of element in "track"
        %
        % Return value vectort: position vector in indexed element of obj
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [vector, state] = get_vector(obj, index);
        
        % Get time stamp:
        %
        % Parameter obj: object
        % Parameter index: index of element in "track"
        %
        % Return value tstamp: value of time stamp in indexed element
        % of obj
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [tstamp, state] = get_time_stamp(obj, index);
        
        % Set frame:
        %
        % Parameter obj: object
        % Parameter frame: frame that should be stored
        % Parameter index: index of element in "track" where frame should
        % be stored
        %
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [state] = set_frame(obj, frame, index);
            
        % Set rotation matrix:
        %
        % Parameter obj: object
        % Parameter rotmat: rotation matrix that should be stored
        % Parameter index: index of element in "track" where rotation
        % matrix should be stored
        %
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [state] = set_rotmat(obj, rotmat, index);
        
        % Set rotation matrix by using zyx-euler-angles
        %
        % The function sets the rotation matrix of an element of
        % attribute "track" by providing the three zyx-euler-angles A, B
        % and C.
        %
        % Parameter obj: Object
        % Parameter A: rotation angle around the z-axis
        % Parametre B: rotation angle around the y-axis
        % Parameter C: rotation angle around the x-axis
        % Parameter index: index of element in "track" where the rotation
        % matrix should be created
        %
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [state] = set_rotmat_angles(obj, A, B, C, index)
        
        % Set position vector:
        %
        % Parameter obj: object
        % Parameter vector: position vector that should be stored
        % Parameter index: index of element in "track" where position
        % vector should be stored
        %
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [state] = set_vector(obj, vector, index);
      
        % Set time stamp:
        %
        % Parameter obj: object
        % Parameter tstamp: time stamp that should be stored
        % Parameter index: index of element in "track" where time stamp
        % should be stored
        %
        % Return value state: 1 if function was successful and 0 if
        % function failed
        [state] = set_time_stamp(obj, tstamp, index);

    end % methods
     
    methods (Access = private)
        
        % Private methods for internal use only
        
        % Check if index of property "track" is valid
        %
        % Parameter obj: object
        % Parameter index: index of element in property "track" whose
        % existens has to be validated
        %
        % Return value state: 0 if the element with the value of "index"
        % does not exist in property "track", 1 if element exists
        [state] = valid_index(obj, index);
        
        % Get the distance between two poses
        % 
        % Parameter obj: object
        % Parameter pos1_idx: index of the element of "track" with the
        % starting point
        % Parameter pos2_idx: index of the element of "track" with the
        % ending point
        %
        % Return value distance: distance between the given poses
        % Return value state: 1 if the function was successful, 0 if not
        [distance, state] = get_distance(obj, pos1_idx, pos2_idx);
        
        % Plot the coordinate system for an element of "track"
        %
        % The function plots a single element of "track" with its
        % orientation represented by a coordinate system.
        %
        % Parameter obj: object
        % Parameter axis_len: length of the coordinate system vectors x, y
        % and z
        % Parameter index: index of element in "track"
        %
        % No return values
        plot_coord_sys(obj, axis_len, index);
                
    end % private methods
   
end % cTrack