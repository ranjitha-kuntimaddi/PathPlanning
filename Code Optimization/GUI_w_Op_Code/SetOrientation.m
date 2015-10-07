% Function name: SetOrientation
% Function to set the orientation of each frame depending on the use case
% Input: 
%		inputTrack:				Path for which the orientation has to be changed
%		useCase:				Use case dependent on the user input 
%		constAngleForCutting:	Constant angle for cutting, which is only valid for cutting use case and also dependent on the user input
% Output: 
%		outputTrack: 			Path with corrected orientation

function [ outputTrack ] = SetOrientation( inputTrack, useCase,constAngleForCutting)

% Use case 1: Cutting
% X-angle calc from surface normale
% Y-Angle const.
% Z-angle along path
if useCase == 1
    for i=1 : 1 : inputTrack.number_of_elements()
        
        %gets the vector of the surface normale
        rot = inputTrack.get_rotmat(i); 
        vecSurfaceNormale = rot(:,3);
        
        %gets the vector to the next point of the path
        if i < inputTrack.number_of_elements()
            vecAlongPath = getVecToNextPoint(inputTrack,i);
        end
        
        %calculates the new koordinate system/orientation of the point
        %depending on the surface normale and the vector to the next point
        z = vecSurfaceNormale/norm(vecSurfaceNormale);
        y = cross(z, (vecAlongPath/norm(vecAlongPath)) );
        y = y/norm(y);
        x = cross(y,z);
        rotMat = [x y z];
        
        %adding the constant angle around the y-axis
        A=0;
        B=-constAngleForCutting; %+180
        C=0;
        inputTrack.set_rotmat_angles(A,B,C,i);
        rotMatTemp = inputTrack.get_rotmat(i);
        rotMat = rotMat*rotMatTemp;
        %set the new koordinate system/ orientation
        inputTrack.set_rotmat(rotMat,i);

    end
end

% Use case 2: Sewing
% X-angle calc from surface normale
% Y-angle calc from surface normale
% Z-angle along path
if useCase == 0
    for i=1 : 1 : inputTrack.number_of_elements()
        
        %gets the vector of the surface normale
        rot = inputTrack.track(i).rotmat;        
        vecSurfaceNormale = rot(:,3);
        
        %gets the vector to the next point of the path
        if i < inputTrack.number_of_elements()
            vecAlongPath = getVecToNextPoint(inputTrack,i);
        end
        
        %calculates the new koordinate system/orientation of the point
        %depending on the surface normale and the vector to the next point
        z = vecSurfaceNormale/norm(vecSurfaceNormale);
        y = cross(z, (vecAlongPath/norm(vecAlongPath)) );
        y = y/norm(y);
        x = cross(y,z);
        rotMat = [x y z];
        %set the new koordinate system/ orientation
        inputTrack.set_rotmat(rotMat,i);

    end
end

outputTrack = inputTrack;

end % end of SetOrientation