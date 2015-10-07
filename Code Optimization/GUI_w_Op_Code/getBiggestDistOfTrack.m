% Function name: getBiggestDistOfTrack
% Function to get the point with biggest distance realtet to the two
% nearest points
% Input: 
%       track:          Object of cTrack class 
%       startIndex:     Starting index of the algorithm
%       endIndex:       Ending index of the algorithm
%       refDistance:    Reference Distance
% Output:
%       Frame:          Frame of the coorinate system with the biggest
%       				distance
%       index:          Index of the coorinate system with the biggest
%       				distance

function [ frame ,index ] = getBiggestDistOfTrack( track ,startIndex,endIndex, refDistance )

startVector = [track(startIndex,1,4), track(startIndex,2,4), track(startIndex,3,4)];
endVector = [track(endIndex,1,4), track(endIndex,2,4), track(endIndex,3,4)];
%startVector = track.get_vector(startIndex);
%endVector = track.get_vector(endIndex);
biggestDistance = refDistance;
frame = 0;
index = 0;

%Seach point with the biggest distance
if endIndex-startIndex > 1;
    for i = startIndex+1 : endIndex-1
        %currentVector =track.get_vector(i);
        currentVector =[track(i,1,4), track(i,2,4), track(i,3,4)];
        distance = calcdist_v2(startVector,endVector,currentVector);
        if biggestDistance < distance;
            biggestDistance = distance;
            %frame = track.get_frame(i); 
            frame = 0;
            index = i;
        end
    end
end
