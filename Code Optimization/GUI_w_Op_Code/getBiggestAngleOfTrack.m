% Function name: getBiggestAngleOfTrack
% Function to get the point with the biggest Angle of the coordinate system
% related to the two nearest points
% Input: 
%       track:          Object of cTrack class 
%       startIndex:     Starting index of the algorithm
%       endIndex:       Ending index of the algorithm
%       refAngle:       Reference Angle
% Output:
%       Frame:          Frame of the coorinate system with the biggest angle
%       index:          Index of the coorinate system with the biggest
%       				angle

function [frame ,index] = getBiggestAngleOfTrack( track ,startIndex,endIndex, refAngle )

startFrame = reshape(track(startIndex,:,:),4,4);
endFrame = reshape(track(endIndex,:,:),4,4);
%startFrame = track.get_frame(startIndex);
%endFrame = track.get_frame(endIndex);
biggestAngle = refAngle;
frame = 0;
index = 0;

%Searchs the biggest angle in the input track
if endIndex-startIndex > 1;
    for i = startIndex+1 : endIndex-1
        %currentFrame =track.get_frame(i);
        currentFrame =reshape(track(i,:,:),4,4);
        angleToStart = getAngle(startFrame,currentFrame);
        angleToEnd = getAngle(endFrame,currentFrame);
        angle = (angleToStart + angleToEnd)/2;
        if biggestAngle < angle;
            biggestAngle = angle;
            frame = currentFrame;
            index = i;
        end
    end
end

end

