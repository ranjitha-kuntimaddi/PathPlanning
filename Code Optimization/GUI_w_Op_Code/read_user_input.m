% Function name: read_user_input
% Function to read data form userinput-file into a structure
% Input:
%		file:			Name of the user input .txt-file
%		Inputtrack:		object of cTrack class to get maximum length of the recorded path
% Output:
%		Uinput:			Structure of user input parameters

function [Uinput] = read_user_input(file,Inputtrack)
              
    if (nargin ~= 2)
        
        error('The function need a file of type .txt to read and the original path as an object!')
        
    elseif (nargin == 2)
        
        % number of input paramters (without the optional parameter for path sequencing)
        K = 12;
              
        %% Reading out the user input data
        %for using the function textscan, the file have to be opened
        fid = fopen(file);

        % read data from UserInputData.txt stepwise with the function textscan 
        % read first of all the ProgramName as a string
        B = textscan(fid, '%s %s', 1, 'delimiter', ':', 'commentstyle', '%');

        % read the other input parameters as a floating-point number until the headline 'Path Sequences' 
        C = textscan(fid, '%s %f', K-1, 'delimiter', ':', 'commentstyle', '%');

        % read the  Path Sequence (optional) 
        D = textscan(fid, '%d %f %f', 'delimiter', ', ', 'commentstyle', '%');
        
        % the file has to be closed at the end of the scanprocess 
        fclose(fid);
        
        % the path sequences will translate in a matrix [nx3] 
        D = [D{1},D{2},D{3}];
        
        %m is the number of path sequences and n is the number of parameter
        %to describe the path sequence. (n has to be 3)
        [m,n]=size(D);

        
        %% Queries of the read input 
          
        if C{2}(1) ~= 0 && C{2}(1) ~= 1
            error('The parameter "CuttingMode" has to be only 0 or 1')
        elseif length(C{2}) < K-1
            error('The inputparameters have to be numbers')
        else
            for j=1:1:K-1
                if isnan(C{2}(j))
                    error('Please insert for each paramater in the inputfile a corresponding value')
                end
            end
        end
        
        % Query for the input values of the path sequences
        
        % Number_of_elements
        [number] = number_of_elements(Inputtrack);
        
        if isempty(D)
            
        elseif n ~= 3
            error('Number of parameters in the pathsequences has to be 3')
        elseif D(1,1) ~= 1
            error('The first Startpoint has to be 1')
        elseif D(m,1) >= number
            error(['The last Startpoint has to be smaller than ' num2str(number)])
        end
      
        %% Create a structure with the read parameters
        Uinput =  struct('ProgName', B{2}, char(C{1}(1)), C{2}(1) , char(C{1}(2)), C{2}(2),...
                         char(C{1}(3)), C{2}(3), char(C{1}(4)), C{2}(4), char(C{1}(5)), C{2}(5),...
                         char(C{1}(6)), C{2}(6), char(C{1}(7)), C{2}(7), char(C{1}(8)), C{2}(8),...
                         char(C{1}(9)), C{2}(9), char(C{1}(10)), C{2}(10), char(C{1}(11)), C{2}(11),...
                         'PathSequence', D);
        
    end % nargin check
 
end % end of read_user_input
