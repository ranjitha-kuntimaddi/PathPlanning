function write_to_file(obj, filename)

    % Function to write data from an object of class cTrack to a file
    
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
    
    % get number of elements in object
    len = obj.number_of_elements();
     
    if (len == 0)
        % empty data set
        data = [];
    else
        % preallocation of memory for data
        data = zeros(len,13);
        
        % copy data to file
        for i = 1:len
            % get time stamp
            data(i,1) = obj.get_time_stamp(i);
            
            % get frame
            frame = obj.get_frame(i);

            % position vector
            data(i,2:4) = (frame(1:3,4))';

            % rotation matrix
            data(i,5:7) = frame(1,1:3);
            data(i,8:10) = frame(2,1:3);
            data(i,11:13) = frame(3,1:3);    
        end % copy data to file
    end
    
    % write data to file
    dlmwrite(filename, data, 'delimiter', '\t', 'precision', '%.6f', ...
        'newline', 'pc');
    
end % write_to_file()

