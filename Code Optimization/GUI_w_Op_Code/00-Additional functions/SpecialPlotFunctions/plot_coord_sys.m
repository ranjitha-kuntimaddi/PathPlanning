function [] = plot_coord_sys(frame, vLen)

    % Function to plot a coordinate system using a frame
    %
    % Parameter 1: frame of a pose
    % Parameter 2: length of the coordinate system vectors
    %
    % No return values
    %
    
    % get size of frame
    [rows cols] = size(frame);      % number of rows and columns

    % check size of parameter frame
    if ~((rows == 4 ) && (cols == 4))
        warning('Parameter "frame" has to be a 4x4 matrix');
        return;
    end % check size of parameter frame
    
    % search for infinit values or NaN in rows of frame
    checkNAN = zeros(1,cols);
    checkINF = zeros(1,cols);
    for i = 1:rows
        data = frame(i,:);
        checkNAN(1,i) = max(isnan(data));
        checkINF(1,i) = max(isinf(data)); 
    end % searche for inifinte values or NaN in rows of frame
    
    % check for infinit values
    if (max(checkINF))
        warning('Parameter "frame" contains infinite element(s)');
        return;
    end % check for infinite values
    
    % check for NaN
    if (max(checkNAN))
       warning('Parameter "frame" contains NaN element(s)');
       return;
    end % check for NaN
        
    
    % Create vectors for coodrinate system. Each axis has one vector.
     
    % x axis
    
    len = sqrt(frame(1,1)^2 + frame(2,1)^2 + frame(3,1)^2) / vLen;
    Xx = [frame(1,4) frame(1,4)+(frame(1,1)/len)];
    Xy = [frame(2,4) frame(2,4)+(frame(2,1)/len)];
    Xz = [frame(3,4) frame(3,4)+(frame(3,1)/len)];
    
    % y axis
    len = sqrt(frame(1,2)^2 + frame(2,2)^2 + frame(3,2)^2) / vLen;
    Yx = [frame(1,4) frame(1,4)+(frame(1,2)/len)];
    Yy = [frame(2,4) frame(2,4)+(frame(2,2)/len)];
    Yz = [frame(3,4) frame(3,4)+(frame(3,2)/len)];
    
    % z axis
    len = sqrt(frame(1,3)^2 + frame(2,3)^2 + frame(3,3)^2) / vLen;
    Zx = [frame(1,4) frame(1,4)+(frame(1,3)/len)];
    Zy = [frame(2,4) frame(2,4)+(frame(2,3)/len)];
    Zz = [frame(3,4) frame(3,4)+(frame(3,3)/len)];
    
    % check if hold is on
    merker = ishold();
    hold on;
    
    % plot x axis vector
    plot3(Xx, Xy, Xz, 'b', 'LineWidth', 2);
    % plot y axis vector
    plot3(Yx, Yy, Yz, 'r', 'LineWidth', 2);
    % plot z axis vector
    plot3(Zx, Zy, Zz, 'g', 'LineWidth', 2);
    
    if ~(merker)
        hold off;
    end        

end % plot_coord_sys()

