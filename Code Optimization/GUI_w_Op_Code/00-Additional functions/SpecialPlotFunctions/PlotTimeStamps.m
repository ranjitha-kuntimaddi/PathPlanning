function [ ] = PlotTimeStamps( Track, Name )
%PLOTTIMESTAMPS Summary of this function goes here
%   Detailed explanation goes here
n_zero_stamp = 0;
for i = 1:Track.number_of_elements
    stamp(i) = Track.get_time_stamp(i);
    if (Track.get_time_stamp(i) < 0)
        n_zero_stamp = n_zero_stamp+1;
        zero_stamp(n_zero_stamp) = i;
    end
    if(i<Track.number_of_elements)
        delta_t(i) = Track.get_time_stamp(i+1)-Track.get_time_stamp(i);
    end
end

min(delta_t)
max(delta_t)

figure('name',Name,'NumberTitle','off');
hold on;
grid on;
plot(1:i,stamp,'r',1:i-1,delta_t,'g');
hleg1 = legend('Timestamp','delta_t');
set(hleg1,'Location','NorthWest');
xlabel('n Point');
ylabel('t');
title(['min(delta_t)=' num2str(min(delta_t)) ...
    sprintf('\nmax(delta_t)=') num2str(max(delta_t))  ...
    sprintf('\n negative time stamps ') int2str(n_zero_stamp)]);
end
