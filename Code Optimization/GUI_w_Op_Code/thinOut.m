% Function name: thinOut
% Function to thin out a track of the class cTrack
% Input:
%		inputTrack:		Object of cTrack class which is going to be thined out 
%		refAngle:		Reference angle to get characteristic points of the path
% 		refDistance:	Reference distance 
%		plot: 			Parameter to activate the plot within the function
% Output:
%		finalTrack:		thined out object of cTrack class

function [ finalTrack ] = thinOut(inputTrack,refAngle,refDistance, plot )

s = inputTrack.number_of_elements();
%%% i preallocation
%i = zeroes(length(s));
%%%

%If plot is equal to 1 the progress of the the thinOut is shown in a figure
if plot == 1
    figure;
    hold on;

    for i = 1:s
        currentVec = inputTrack.get_vector(i);
        plot3(currentVec(1),currentVec(2),currentVec(3));
    end
    axis equal
    startPoint = inputTrack.get_vector(1);
    plot3(startPoint(1),startPoint(2),startPoint(3),'o', 'Linewidth', 2);
    endPoint = inputTrack.get_vector(s);
    plot3(endPoint(1),endPoint(2),endPoint(3),'o', 'Linewidth', 2);
end

%Creats the index array
%In the index array all points which are not thinned out are stored
indexArray = [1 s];

%copies the frames in an array
for i = 1:s
    inputTrackArray(i,:,:) = inputTrack.get_frame(i);
end

%Thinning out of the track by using the recursive thin out
indexArray = thinOutRec(inputTrackArray, indexArray,1,s,refAngle,refDistance,plot);

%Sort the indexes create a new cTrack object
indexArray = sort(indexArray);
finalTrack = cTrack();
sizeFinalTrack = size(indexArray);
sizeFinalTrack = sizeFinalTrack(2);

%Copies the points which are not thinned out into the new cTrack object
%finalTrack holds the final thinned out track
%%%
%i = zeroes(length(sizeFinalTrack));
%%%
for i = 1:sizeFinalTrack
    finalTrack.new_element();
    copy_element(finalTrack,i,inputTrack,indexArray(i));
end

%if plot is equal to 1 the final thined out track is plotted
if plot == 1
    figure;
    hold on;
    %%%
    i = zeroes(length(finalTrack.number_of_elements()));
    currentVec = zeroes(length(finalTrack.number_of_elements()));
    %%%
    for i = 1:finalTrack.number_of_elements()
        currentVec = finalTrack.get_vector(i);
        plot3(currentVec(1),currentVec(2),currentVec(3),'o', 'Linewidth', 2);
        %pause
    end
    axis equal;
end

end % end of thinOut