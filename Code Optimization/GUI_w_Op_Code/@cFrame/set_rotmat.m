function [state] = set_rotmat(obj, rotmat)

    % Set the rotation matrix in class cFrame.

    % get size of rotmat
    [rows cols] = size(rotmat);     % number of rows and columns
    
    % parameter vector length tolerance
    % ONLY INTERNAL USE
    VECT_LEN_TOL = 10^-5;

    % check size of parameter rotmat
    if ~((rows == 3 ) && (cols == 3))
        warning('Parameter "rotmat" has to be a 3x3 matrix');
        state = 0;      % function failed
        return;
    end % check size of parameter rotmat
    
    % check determinant of the rotation matrix
    a = det(rotmat);    
    if (abs(abs(a)-1) >= VECT_LEN_TOL)
        disp('Parameter "rotmat" is no cartesian rotation matrix');
        warning(['Determinant is ' num2str(a,8) ', but should be 1']);
        state = 0;      % function failed
        return;
    end % check determinat of the rotation matrix
    
    % check rotation matrix vectors
    x = norm(rotmat(:,1));
    y = norm(rotmat(:,2));
    z = norm(rotmat(:,3));
    if ((abs(abs(x)-1) >= VECT_LEN_TOL) || isnan(x))
        warning(['Parameter "rotmat" has a x-vector with a length ' ...
            'unequal to 1']);
        state = 0;      % function failed
        return;
    end
    if ((abs(abs(y)-1) >= VECT_LEN_TOL) || isnan(y))
        warning(['Parameter "rotmat" has a y-vector with a length ' ...
            'unequal to 1']);
        state = 0;      % function failed
        return;
    end
    if ((abs(abs(z)-1) >= VECT_LEN_TOL) || isnan(z))
        warning(['Parameter "rotmat" has a z-vector with a length ' ...
            'unequal to 1']);
        state = 0;      % function failed
        return;
    end % check rotation matrix vectors
    
    % copy parameter rotmat to class property rotmat
    obj.rotmat = rotmat;
    state = 1;          % function successful

end % set_rotmat()

