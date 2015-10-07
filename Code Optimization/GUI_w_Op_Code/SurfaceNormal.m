% Function name: SurfaceNormal
% Function to calculate the normal of the surface
% Input: 
%			Surface:	Recorded path which describes the surface
%			Path: 		Recorded path

function [] = SurfaceNormal(Surface, Path)        

for i=1:Surface.number_of_elements-1   
    for j=1:Path.number_of_elements-1   
         
        S1 = Surface.get_vector(i);                                         % first point for straight line equation with points of the Surface-Path
        P1 = Path.get_vector(j);                                            % first point for straight line equation with points of the Working-Path
        
        if (norm(S1-P1)<50)                                                 % Only check dropped perpendicular foots of straight lines equations
                                                                            % which position vectors of the supporting points are not too far away,
                                                                            % because it it unlikely to result in a intersection.
            
            S2 = Surface.get_vector(i+1);                                   % second point for straight line equation with points of the Surface-Path
            P2 = Path.get_vector(j+1);                                      % second point for straight line equation with points of the Surface-Path

            % setting up straight line equations
            nA = dot(cross(P2-P1,S1-P1),cross(S2-S1,P2-P1));
            nB = dot(cross(S2-S1,S1-P1),cross(S2-S1,P2-P1));
            d  = dot(cross(S2-S1,P2-P1),cross(S2-S1,P2-P1));
            
            % dropped perpendicular foots (X = Intersection of with normal)
            XS = S1 + (nA/d)*(S2-S1);                                       % Intersection with normal and Surface-Path (S = Surface)
            XP = P1 + (nB/d)*(P2-P1);                                       % Intersection with normal and Working-Path (S = Surface)
            
            if ( InBetween(S1,XS,S2) && InBetween(P1,XP,P2) )               % check if dropped perpendicular foot lay within line seqments 
                Path.new_element(j+1);                                      % add new point to the working-path
                Path.set_vector(XP,j+1);                                    % set position vector of dropped perpendicular foot to new point
                rot = calcNormVect(XS,XP,P2,Path.get_rotmat(j));            % calculate rotational matrix with z-vector normal to surface and x following path direction
                Path.set_rotmat(rot,j+1);                                   % add rotational matrix to new point
            end
        end
    end
end

% delete all other rotations matrizes off the Path
rot = [ 0 0 0; 0 0 0; 0 0 0];

for i = 1:Path.number_of_elements
    if (Path.get_time_stamp(i) > 0)                                         % all points which have been added to to path above, get by default a negative time stamp
        %Path.set_rotmat(rot,i);                                             % to delete the rotational matrices of all points but the added ones
		Path.track(i).rotmat = rot;
    end                                                                     % the points with positive timestamps have to be considered
end
% interpolate the rotational matrizes of the points between intersection
% points
ReCalc(Path);


% to improve accuracy introduction of the follwing parameter could help:
% dist_min =  ..; % minimal distance between intersection Point (XS resp. XP) 
%                 % and supporting points to build straight line (S1,S2 resp. P1,P2)
%                 % because a too small distance is likely to yield in a disturbed
%                 % result
end % end of SurfaceNormal