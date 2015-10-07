% Function name: stopwatch
% Stopwatch function to measure the time
% Input:
%       control:    Parameter to reset the watch
% Output:
%       time:       Time since last start command

function [time] = stopwatch(control)

    % if control = 0 the watch returns the measured time (in s) since last
    % start command
    % if control = 1 the watch returns the measured time (in s) since last
    % start command and resets the watch
    
    % get CPU time
    dtime = cputime();
    
    % check argument
    if ~((control == 0) || (control == 1))
        error('Input value has to be 0 or 1');
    end % check argument    
    
    % persistant variable to store the time
    persistent time1;
    
    % initialisation of the variable time1
    if isempty(time1);
        time1 = 0;
    end
    
    if (control == 0)
        % return time since last reset command
        time = dtime - time1;
    else
        % return time since last reset command and reset watch
        time = dtime - time1;
        % store actual CPU time
        time1 = dtime;
    end

end % end of stopwatch

