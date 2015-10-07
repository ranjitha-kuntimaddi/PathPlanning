function [ ] = PlotAngleGraph( Track, Name )
%PLOTANGLERUN Summary of this function goes here
%   Detailed explanation goes here
for i = 1:Track.number_of_elements
    %rot = Track.get_rotmat(i);
    %D(i) = det(rot);
    pos(:,i) = Track.get_vector(i);
    [A(i), B(i), C(i), state(i)] = Track.get_rotmat_angles(i);
    D(i) = det(Track.get_rotmat(i));
end
max(D) 

figure('name',Name,'NumberTitle','off');

hold on;
grid on;
plot (1:i,A,'r',1:i,B,'g',1:i,C,'',1:i,state,'k');
hleg1 = legend('A','B','C','state');
set(hleg1,'Location','NorthWest');
xlabel('n Point');
ylabel('angle Value °');
title(['min(Det)= ' num2str(min(D)) sprintf('\nmax(Det)= ') num2str(max(D))]);
end

