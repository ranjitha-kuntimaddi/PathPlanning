% Function name: ReCalc3
% Function to calculate a valid rotation matrix for every point of the path
% which are based on the crossing points
% Input:
%       Path:           Handle the global path data (object of cTrack class)

function [] = ReCalc3(Path)

Path_end    = Path.number_of_elements;

State       = 'start';      
CP_start    = 0;
CP_end      = 0;
Dist_abs    = 0;
Dist_point  = 0;
Dist        = 0;

%Loop trought every element of the track
for i=1:Path_end
    
    switch State
        
        %This case is only necessary for finding the startpoint, next
        %startpoint is the previous endpoint
        case 'start'
            
            %If the actual element got a valid rotation matrix
            if (isRotmatzero(Path.track(i).get_rotmat)==0)
                CP_start    = i;                                            %The first point with a valid rotation matrix is the startpoint of the calculation
                State       = 'end';                                        %The State get permanently sets to 'end' because the first startpoint was found
                
                %Every point before starting point gets the same rotmat as 
                %the startpoint (because of insufficient information)
                for v=1:(i-1)
                    Path.track(v).rotmat = Path.track(CP_start).rotmat;
                end
            end
            
        %State 'end' is active for the rest of the path
        case 'end'
            
            %If the actual element got a valid rotation matrix
            if (isRotmatzero(Path.track(i).get_rotmat)==0)
                CP_end      = i;                                            %The next point found with a valid rotation matrix get the endpoint
                
                %Calculation of the absoulute distance between start- and 
                %endpoint, because a multiple amount of points could remain 
                %between both points (Loop goes from start- to endpoint)
                for u=1:(CP_end-CP_start)
                    PS         = Path.track(u+CP_start-1).vector;           %Startpoint of distance calculation
                    PE         = Path.track(u+CP_start).vector;             %Endpoint of distance calculation
                    Dist(u)    = calcdist2P(PS,PE);                         %Distance between PS und PE
                    Dist_abs   = Dist_abs + Dist(u);                        %Absolute distance for multiple points between PS and PE
                end
                                          
                [As, Bs, Cs, states] = get_rotmat_angles(Path, CP_start);   %Startpoint (valid rotation matrix)
                [Ae, Be, Ce, statee] = get_rotmat_angles(Path, CP_end);     %Endpoint (valid rotation matrix)                
                A = Ae-As;                                                  %Difference of orientation between start and endpoint (Euler Angle A)
                B = Be-Bs;                                                  %Difference of orientation between start and endpoint (Euler Angle B)
                C = Ce-Cs;                                                  %Difference of orientation between start and endpoint (Euler Angle C)
                
                %The follwing lines prevent loopings between crossing 
                %points if one euler angle of the first crossing point has 
                %a value close to +180° and the other crossing point has 
                %the same euler angle close to -180° without these lines 
                %the angular values would be distributed along nearly 360° 
                %what makes a looping with these lines the angles will be 
                %distributed in the along the shortest angular distance.
                %To make sure that the angle values of the points between 
                %crossing points  
                if(A>=180)
                    A = -360+A;
                elseif(A<-180) 
                    A = 360+A;
                end
                
                if(B>=180)          
                    B = -360+B;
                elseif(B<-180)     
                    B = 360+B;
                end
                
                if(C>=180)       
                    C = -360+C;
                elseif(C<-180)     
                    C = 360+C;
                end
                
                %Every point between start- and endpoint gets, proportional
                %of the position to the distance, allocated a rotation
                %matrix    
                for u=(CP_start+1):(CP_end-1)
                    
                    %Distance between the actual point and startpoint
                    %(Multiple fraction distances possible)
                    for v=1:(u-CP_start)
                        Dist_point = Dist_point+Dist(v);                    %Fraction distances get added
                    end
                    
                    rate        = Dist_point/Dist_abs;                      %Proportion of the distance to the actual point to the entire distance
                                       
                    Ap = (A*rate)+As;                                       %Euler Angle A for the Point is the Difference of orientation times the position proportional to the whole distance, plus the orientation of the startpoint
                    Bp = (B*rate)+Bs;                                       %Euler Angle B for the Point is the Difference of orientation times the position proportional to the whole distance, plus the orientation of the startpoint
                    Cp = (C*rate)+Cs;                                       %Euler Angle C for the Point is the Difference of orientation times the position proportional to the whole distance, plus the orientation of the startpoint
                    
                    %To make sure the euler angles only have values 
                    %beween +180° and -180°           
                    if(Ap>=180) 
                        Ap=-360+Ap;
                    elseif(Ap<-180)
                        Ap=+360-Ap;
                    end
                    
                    if(Bp>=180)
                        Bp=-360+Bp;
                    elseif(Bp<-180)
                        Bp=+360-Bp;
                    end
                    
                    if(Cp>=180)
                        Cp=-360+Cp;
                    elseif(Cp<-180)
                        Cp=+360-Cp;
                    end
                    
                    set_rotmat_angles(Path, Ap, Bp, Cp, u);                 %Set the calculated Euler Angle to a rotation matrix for the actual point                                        
                    Dist_point  = 0;                                        %For the next calculation the fraction distance get reset to zero
                end  
                
                CP_start    = i;                                            %Next startpoint is actual endpoint (next endpoint gets searched)
                Dist_abs    = 0;                                            %For the next calculation the absolute distance get reset to zero            
            end
            
            %If the end of the path is reached and the endpoint got an in-
            %valid rotation matrix
            if ((i == Path_end) && (CP_end ~= Path_end))
                
                %The last valid rotation matrix (of the last endpoint) gets
                %the rotaion matrix for every point left (because of 
                %insufficient information)
                for u=(CP_end+1):Path_end
                    Path.track(u).rotmat = Path.track(CP_end).rotmat;       %allocate rotation matrix
                end
            end
    end    
end

n_zero_stamp=0;                                                             %Counter for the number of points with invalid rotation matrix
zero_stamp  =0;                                                             %Vector with the position in the Path for each Point with invalid rotation matrix

%Cleanup of every crossing point, because they lie on a straight line 
%(only corner points got important information) and missing the information
%of a time stamp (which is necessary for the interpolation)
for i = 1:Path.number_of_elements
    
    %If the actual point got an invalid time stamp
    if (Path.get_time_stamp(i) < 0)
        n_zero_stamp = n_zero_stamp+1;                                      %Point with invalid rotation matrix is found
        zero_stamp(n_zero_stamp) = i;                                       %Position of the point gets stored
    end
end

%Loop for every element found with an invalid rotation matrix
for i = 1:n_zero_stamp                          
    Path.delete_element(zero_stamp(i)-(i-1));                               %Deleting the element stored in the zero_stamp vector (minus i index because the length eased by every erasure, for correct position)
end

end % end of ReCalc3


