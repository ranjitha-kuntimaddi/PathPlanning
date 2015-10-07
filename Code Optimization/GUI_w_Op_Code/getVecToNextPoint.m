% Function name: getVecToNextPoint
% Function to get vector to the next point in the track
% Input: 
%       inputTrack:         Object of cTrack class 
%       indexCurrentPoint:  Index of the current point
% Output:
%       retVec:             Calcutlated vector

function [ retVec ] = getVecToNextPoint( inputTrack, indexCurrentPoint )

retVec = inputTrack.get_vector(indexCurrentPoint+1) - inputTrack.get_vector(indexCurrentPoint);

end % end of getVecToNextPoint
