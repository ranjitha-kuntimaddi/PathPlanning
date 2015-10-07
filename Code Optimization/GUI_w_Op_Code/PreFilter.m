% Function name: Filter
% Function to delete measuring errors from recorded path
% Input:
% 		obj:		Object of cTrack class which is going to be filtered
%		vecAngle:	Maximal angle between two vectors 
%		maxlength:  Maximal length between two recorded points
%		StartBall: 	Radius of sphere around the starting point within all points are deleted
%		EndBall:	Radius of sphere around the end point within all points are deleted


function Filter(obj, vecAngle, maxlength, StartBall, EndBall)

maxangle = 0.05;
offsetdeltaFaktor = 1;

%% Filter dependent on MaxLength
for x=obj.number_of_elements-1:-1:2
          
    temp_frame1 = obj.get_vector(x);
    temp_frame2 = obj.get_vector(x-1);
    
    veclength = abs(sqrt((temp_frame2(1,1)-temp_frame1(1,1))^2+(temp_frame2(2,1)-temp_frame1(2,1))^2+(temp_frame2(3,1)-temp_frame1(3,1))^2));

    if( veclength >= offsetdeltaFaktor*maxlength)
         obj.delete_element(x-1);
         offsetdeltaFaktor = offsetdeltaFaktor+1; 
    else
        offsetdeltaFaktor = 1;
    end
   
end

%% Filter dependent on MaxAngle
x=0;
for x=obj.number_of_elements-1:-1:2
 
    % get rotation matrices
    temp_rot1=obj.get_rotmat(x);
    temp_rot2=obj.get_rotmat(x-1);
    
    % Calculate Euler-angles
    A1 = atan2(temp_rot1(2,1),temp_rot1(1,1));
    A2 = atan2(temp_rot2(2,1),temp_rot2(1,1));
    B1 = asin(temp_rot1(3,1));
    B2 = asin(temp_rot2(3,1));
    C1 = atan2(temp_rot1(3,2),temp_rot1(3,3));
    C2 = atan2(temp_rot2(3,2),temp_rot2(3,3));
    
    %%%
    if((abs(A1-A2)>= maxangle)|(abs(B1-B2)>= maxangle)|(abs(C1-C2)>= maxangle))
       obj.delete_element(x-1);
%        disp('Angle>=MAX angle');
    end
end


%% StartFilter-Point

Startfilter = 1;
while(Startfilter)
    sP1 = obj.get_vector(1);
    sP2 = obj.get_vector(2);
   
    startPointabs = abs(sqrt((sP1(1,1)-sP2(1,1))^2+(sP1(2,1)-sP2(2,1))^2+(sP1(3,1)-sP2(3,1))^2));

    if (startPointabs<=StartBall)
         obj.delete_element(2);
    else
        sP3 = obj.get_vector(3);
        startPointabsSec = abs(sqrt((sP1(1,1)-sP3(1,1))^2+(sP1(2,1)-sP3(2,1))^2+(sP1(3,1)-sP3(3,1))^2));
        if (startPointabsSec<=StartBall) 
            obj.delete_element(2);
            obj.delete_element(2);
        else
           sP4 = obj.get_vector(4);
           startPointabsSec = abs(sqrt((sP1(1,1)-sP4(1,1))^2+(sP1(2,1)-sP4(2,1))^2+(sP1(3,1)-sP4(3,1))^2));
           if (startPointabsSec<=StartBall) 
                obj.delete_element(2);
                obj.delete_element(2);
                obj.delete_element(2);
           else
             Startfilter = 0; %abbruch            
        end
    end
  
    end

%% ENDFilter-Point
acEnd = obj.number_of_elements-1;
Endfilter = 1;
while(Endfilter)
    eP1 = obj.get_vector(acEnd);
    eP2 = obj.get_vector(acEnd-1);
    
    endPointabs = abs(sqrt((eP1(1,1)-eP2(1,1))^2+(eP1(2,1)-eP2(2,1))^2+(eP1(3,1)-eP2(3,1))^2));
     if (endPointabs<=EndBall)
         obj.delete_element(acEnd-1);
         acEnd =acEnd - 1;
     else
             Endfilter = 0;
     end
     
         
end
%% Just for testing
% x=0
% figure(99)
% plotTrack(obj,'m',0)

%% Prefiltering of too small angles in the path (not orientation)
for x=obj.number_of_elements-2:-1:3
   
    temp_frame1 = obj.get_vector(x); % Read last
    temp_frame2 = obj.get_vector(x-1); % Read last - 1
    temp_frame3 = obj.get_vector(x-2); % Read last -2
    
    vec12 = temp_frame2-temp_frame1; % create vec from 1 to 2
    vec23 = temp_frame3-temp_frame2; % create vec from 2 to 3
    
    %Calculate angle between two vectors
    angle = acos(dot(vec12,vec23)/((sqrt(vec12(1)^2+vec12(2)^2+vec12(3)^2))*(sqrt(vec23(1)^2+vec23(2)^2+vec23(3)^2)))); % calculate angle between vec12 and vec23 
    angle =  angle * (180/pi); % get angle in degree°
    angle = abs(angle); % get the absolute value of angle
    if (angle >= 180)
        angle =  360-angle;
    end
    
    if (abs(angle) < 90)
       toDelete = 0; % if smaler 90° 
       
       for y=(x-3):-1:(x-7)
           if y<=2 % if path is finished
%               disp('break')
                break % get out of the loop                   
           end
               
           frameY = obj.get_vector(y);
           vec2y = frameY - temp_frame2;
           angleY = acos(dot(vec12,vec2y)/((sqrt(vec12(1)^2+vec12(2)^2+vec12(3)^2))*(sqrt(vec2y(1)^2+vec2y(2)^2+vec2y(3)^2))));
           angleY = angleY * (180/pi);
           angleY = abs(angleY);
           
           if (angleY>=180)
                angleY =  360-angleY;
           end

           if (abs(angleY-angle)>vecAngle)
                toDelete = 1;
           end
       end % End of for-loop
       
       if(toDelete == 1)
            obj.delete_element(x-2);
            % Plot deleted points for testing
%             plot3(temp_frame3(1),temp_frame3(2),temp_frame3(3),'or')
       end
   end % End of if abs(angle) < 90
end

end % end of filter

