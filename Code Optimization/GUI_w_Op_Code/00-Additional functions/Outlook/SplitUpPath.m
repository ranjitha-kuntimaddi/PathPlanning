function [Sequences] = SplitUpPath(PathSequenz)
% This function splits up the path into sequences 
% The output is an array of cTrack-objects
% The number of sequences is read out from the parameter input-file

% Calculate number of Sequences from user input
[m, n] = size(PathSequenz);
% Create an array of empty cTrack-objects with m colums
Track(m) = cTrack();
% Create object of original path
obj_orig = cTrack('C:\Users\Nina\Documents\MATLAB\Master-Project\main_mFile\Pathes\path.csv');

%Create an array of start and end indexes for the sequences
seq = PathSequenz(1:m);
endSeq = seq-1;
endSeq(1) = [];
last = length(endSeq)+1;
endSeq(last) = number_of_elements(obj_orig);


% Fill array of objects (Track) with path data from original path
for i=1:length(seq)
    for s1= seq(i):1:endSeq(i)
        idx = Track(i).new_element();
        copy_element(Track(i), idx, obj_orig, s1);
    end
end

% Output is an array of cTrack-objects
Sequences = Track;

end
