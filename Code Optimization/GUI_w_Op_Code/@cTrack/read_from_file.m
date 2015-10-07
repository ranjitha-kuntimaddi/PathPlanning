function read_from_file(obj, filename)

    % Function to read data from a file into an object of class cTrack
    
    % Content of the file
    %
    % Every row of the file holds one pose with time stamp, 3D position
    % vector and a 3D rotation matrix.
    %
    % List of row elements:
    % 1) Time stamp (in ms) 
    % 2) x part of the vector
    % 3) y part of the vector
    % 4) z part of the vector
    % 5) rotation matrix element A(1,1)
    % 6) rotation matrix element A(1,2)
    % 7) rotation matrix element A(1,3)
    % 8) rotation matrix element A(2,1)
    % 9) rotation matrix element A(2,2)
    % 10) rotation matrix element A(2,3)
    % 11) rotation matrix element A(3,1)
    % 12) rotation matrix element A(3,2)
    % 13) rotation matrix element A(3,3)
    
    % check parameter filename
    if ~ischar(filename)
        error('Parameter "filename" has to be string');
    end % check parameter filename
    
    % read data from file
    data = dlmread(filename);
      
    % get number of rows and columns of data
    [rows cols] = size(data);
    
    % if there are data stored in the class they will be deleted
    obj.delete_all_elements();
    
    % initialize property "track" with default values
    obj.track = cPose(rows);
    
    % copy data into track
    for i = 1:rows
                   
        % set time stamp in class
        obj.track(i).set_time_stamp(data(i,1));
        
        % default object
        frame = eye(4);
        
        % position vector
        frame(1:3,4) = (data(i,2:4))';
        
        % rotation matrix
        frame(1,1:3) = data(i,5:7);
        frame(2,1:3) = data(i,8:10);
        frame(3,1:3) = data(i,11:13);
        
        % set frame in class
        obj.track(i).set_frame(frame);
                  
    end % copy data into track

end % read_from_file()

