function [distance, state] = get_distance(obj, pos1_idx, pos2_idx)

    % Returns the distance between to poses of the track
    
    % check parameters
    state1 = obj.valid_index(pos1_idx);
    state2 = obj.valid_index(pos2_idx);
    if ~(state1 && state2)
        % invalid index found
        distance = [];
        state = 0;      % function failed
        return;
    end
    
    % get the two vectors from track
    vector1 = obj.track(pos1_idx).get_vector();
    vector2 = obj.track(pos2_idx).get_vector();
    
    % calculate vector between the two poses
    vector12 = vector2 - vector1;
    
    % calculate distance
    distance = norm(vector12);
    state = 1;          % function successful

end % get_distance()

