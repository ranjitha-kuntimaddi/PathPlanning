% Function name: thinOutRec
% The function thins out a track of the class cTrack recursive
% Input:
%		inputTrack:		Object of cTrack class which is going to be thined out recursively
%		finalTrack:		Object of cTrack class which is the result of the algoritm
%       startIndex:     Starting index of the algorithm
%       endIndex:       Ending index of the algorithm
%		refAngle:		Reference angle to get characteristic points of the path
% 		refDistance:	Reference distance 
%		plot: 			Parameter to activate the plot within the function
% Output:
%		finalTrack:		Object of cTrack class which is the result of the algoritm

function [ finalTrack ] = thinOutRec(inputTrack, finalTrack, startIndex, endIndex , refAngle, refDistance, plot)

%Get the indices of the biggest angle and the biggest distance of the
%track. If the angle or the distance does not exceeds the reference angle
%or reference distance the return index is zero.
[frameAng,indexBigAngle] = getBiggestAngleOfTrack(inputTrack,startIndex,endIndex,refAngle);
[frameDist,indexBigDist] = getBiggestDistOfTrack(inputTrack,startIndex,endIndex,refDistance);

%Case 1: The anlge does exceed the reference value, the distance does not
%exceed the reference value
if indexBigAngle > 0 && indexBigDist == 0
    
% % %     %If plot is equal to 1 the progress of the the thinOut is shown in a
% % %     %figure
% % %     if plot == 1
% % %         currentVec = [inputTrack(indexBigAngle,1,4), inputTrack(indexBigAngle,2,4), inputTrack(indexBigAngle,3,4)];
% % %         figure(1);
% % %         plot3(currentVec(1),currentVec(2),currentVec(3),'o', 'Linewidth', 2);
% % %         %pause
% % %     end
    

    %Adds the index of the point which exceeds the reference value to the
    %final track.
    finalTrack = [finalTrack  indexBigAngle];  
    
    %Splitting the track into subtracks and call the thinOutRec for the
    %subtracks
    [finalTrack] = thinOutRec(inputTrack, finalTrack, startIndex, indexBigAngle, refAngle,refDistance,plot);    
    [finalTrack] = thinOutRec(inputTrack, finalTrack, indexBigAngle, endIndex, refAngle,refDistance,plot);
    
    
%Case 2: The anlge does not exceed the reference value, the distance does 
%exceed the reference value
elseif indexBigAngle == 0 && indexBigDist > 0
    
    %If plot is equal to 1 the progress of the the thinOut is shown in a
    %figure
    if plot == 1
        currentVec = [inputTrack(indexBigDist,1,4), inputTrack(indexBigDist,2,4), inputTrack(indexBigDist,3,4)];
        figure(1);
        plot3(currentVec(1),currentVec(2),currentVec(3),'o','color','r', 'Linewidth', 2);
        %pause
    end
    
    %Adds the index of the point which exceeds the reference value to the
    %final track.
     finalTrack = [finalTrack  indexBigDist];
     
    %Splitting the track into subtracks and call the thinOutRec for the
    %subtracks
    [finalTrack] = thinOutRec(inputTrack, finalTrack, startIndex, indexBigDist, refAngle,refDistance,plot);    
    [finalTrack] = thinOutRec(inputTrack, finalTrack, indexBigDist, endIndex, refAngle,refDistance,plot);
    
%Case 3: The anlge does exceed the reference value, the distance does 
%exceed the reference value
elseif indexBigAngle > 0 && indexBigDist > 0
    
    %If plot is equal to 1 the progress of the the thinOut is shown in a
    %figure
    
    if plot == 1
        currentVec = [inputTrack(indexBigAngle,1,4), inputTrack(indexBigAngle,2,4), inputTrack(indexBigAngle,3,4)];
        figure(1);
        plot3(currentVec(1),currentVec(2),currentVec(3),'o', 'Linewidth', 2);
        currentVec = [inputTrack(indexBigDist,1,4), inputTrack(indexBigDist,2,4), inputTrack(indexBigDist,3,4)];
        figure(1);
        plot3(currentVec(1),currentVec(2),currentVec(3),'o','color','r', 'Linewidth', 2);
        %pause
    end
    
    %Adds the index of the points which exceeds the reference value to the
    %final track.
    finalTrack = [finalTrack  indexBigDist];
    if indexBigDist~=indexBigAngle
        finalTrack = [finalTrack  indexBigAngle];
    end
    
    %Splitting the track into subtracks and call the thinOutRec for the
    %subtracks
    if indexBigAngle < indexBigDist
        [finalTrack] = thinOutRec(inputTrack, finalTrack, startIndex, indexBigAngle, refAngle,refDistance,plot);    
        [finalTrack] = thinOutRec(inputTrack, finalTrack, indexBigAngle, indexBigDist, refAngle,refDistance,plot);
        [finalTrack] = thinOutRec(inputTrack, finalTrack, indexBigDist, endIndex, refAngle,refDistance,plot);
    elseif indexBigAngle > indexBigDist
        [finalTrack] = thinOutRec(inputTrack, finalTrack, startIndex, indexBigDist, refAngle,refDistance,plot);    
        [finalTrack] = thinOutRec(inputTrack, finalTrack, indexBigDist, indexBigAngle, refAngle,refDistance,plot);
        [finalTrack] = thinOutRec(inputTrack, finalTrack, indexBigAngle, endIndex, refAngle,refDistance,plot);
    elseif indexBigAngle == indexBigDist
        [finalTrack] = thinOutRec(inputTrack, finalTrack, startIndex, indexBigAngle, refAngle,refDistance,plot);    
        [finalTrack] = thinOutRec(inputTrack, finalTrack, indexBigAngle, endIndex, refAngle,refDistance,plot);
    end
end
    
end % end of thinOutRec