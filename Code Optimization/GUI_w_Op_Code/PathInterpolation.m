% Function name: PathInterpolation
% Function to interpolate a given path with a certain time stamp
% Input: 
% 		Inputtrack: 	object of cTrack class which is going to be interpolated
% 		T_IPO:			Desired interpolation time given by the user input (here T_IPO=4ms)
% Output:
% 		Outputtrack:	Interpolated path as an object of cTrack class

function [Outputtrack] = PathInterpolation(Inputtrack,T_IPO)
    % Function to interpolate the path in a fixed delta timestamp T_IPO
           
    if (nargin < 2)
        error('Please insert a track as an object and a value for the fixed deltatimestamp T_IPO')
        
    elseif (nargin == 2)
        %%Predefinition of the variables
        
        % Outputtrack is the output object of the function
        Outputtrack = cTrack();
        
        % number of elements from the Inputtrack
        len = Inputtrack.number_of_elements(); 
        
        % positionvector 
        posvector=zeros(3,len); 
       
        % eulerangles in this form (A;B;C)
        eulerangles=zeros(3,len);
        
        % timestamp
        timestamp=zeros(1,len); 
                
        % necessary for the new number of elements
        counter = 0;
        
        % To exclude the points which aren't in the defined deltatimestamp
        lastpointtime = 0;
        
      
        %% Loop for taking the values of the path
        for i = 1:len
            posvector(1:3,i) = Inputtrack.get_vector(i);
            timestamp(i)= Inputtrack.get_time_stamp(i); 
            [eulerangles(1,i),eulerangles(2,i),eulerangles(3,i)] = Inputtrack.get_rotmat_angles(i);
        end %end for i
            
        % deltatimestamp between the timestamps of the path
        deltatimestamp(1:len-1) = timestamp(2:len)-timestamp(1:len-1);
         
            
        %% Query if the given T_IPO is possible to handle in this function
          
        if (min(deltatimestamp(:)) < T_IPO || T_IPO <= 0)
            error(['please choose a T_IPO that is smaller than ' num2str(min(deltatimestamp(:))) ' and bigger then 0'])
        end
        
        %% algorithm for the interpolation
        
        for j=(1:1:len-1)  %%Here the loop will go untill the prelast element of the Data
                               
            % difference between the eulerangle     
            differenceEuler = eulerangles(:,j+1)-eulerangles(:,j);
            
            % Queries so that the euler angles are interpolated in the right
            % direction
            if(differenceEuler(1)>=180)
                differenceEuler(1) = -360+differenceEuler(1);
            elseif(differenceEuler(1)<-180) 
                differenceEuler(1) = 360+differenceEuler(1);
            end
            
            
            if(differenceEuler(2)>=180)
                differenceEuler(2) = -360+differenceEuler(2);
            elseif(differenceEuler(2)<-180)     
                differenceEuler(2) = 360+differenceEuler(2);
            end
                
              
            if(differenceEuler(3)>=180)       
                differenceEuler(3) = -360+differenceEuler(3);
            elseif(differenceEuler(3)<-180)    
                differenceEuler(3) = 360+differenceEuler(3);
            end
                
            % normalized direction vector of the euler angles 
            directionEuler = differenceEuler/deltatimestamp(j);
            
            % normalized direction vector of the positions
            directionV = (posvector(:,j+1)-posvector(:,j))/deltatimestamp(j);
            
            % loop to interpolate the adjacent frames in a linear way
            for k=(lastpointtime:T_IPO:deltatimestamp(j))
                
                % newTimestamp for each new interpolated point
                newTimeStamp = timestamp(1)+counter*T_IPO;
                
                counter = counter + 1;
                
                % interpolation of the positionvector
                newPosVector = directionV*k + posvector(:,j);
                    
                % interpolation of the eulerangles
                neweulerangles = directionEuler*k + eulerangles(:,j);

                %Object definition of the Outtputtrack
                Outputtrack.new_element();
                
                Outputtrack.set_rotmat_angles(neweulerangles(1), neweulerangles(2), neweulerangles(3),counter);
     
                Outputtrack.set_vector(newPosVector(:),counter);
                
                Outputtrack.set_time_stamp(newTimeStamp,counter);

            end %end for k
            
            % the time which is used in the next loop as startpoint for the interpolation
            lastpointtime = k + T_IPO - deltatimestamp(j);
                
        end %end for j
         
        %% last point shall standing in the path
        
        % here the newTimestamp is the timestamp 
        % of the last interpolated point
        if newTimeStamp ~= timestamp(len)
                             
                Outputtrack.new_element();
                                
                Outputtrack.set_rotmat_angles(eulerangles(1,len), eulerangles(2,len), eulerangles(3,len),counter+1);
     
                Outputtrack.set_vector(posvector(:,len),counter+1);
                
                Outputtrack.set_time_stamp(newTimeStamp+T_IPO,counter+1);

        end
    end %end if of the nargin demand
end %end of PathInterpolation
    
