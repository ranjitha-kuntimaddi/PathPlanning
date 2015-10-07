function [index] = new_element(obj, index, varargin)

    % Inserts an element of in "track"
    
    % check number of arguments
    error(nargchk(1, 2, nargin));
    
    % get length of track
    len = length(obj.track);
       
    % check index value
    if (nargin > 1)        
        % check if index is char
        if (ischar(index))
            error('Parameter "index" must be numeric');
        end % check if index is char
        
        % check if index < 1
        if (index < 1)
            error('Parameter "index" must be >= 1');
        end % check if index < 1
        
        % check if index is no integer
        if ((round(index)-index) ~= 0)
            warning('Parameter "index" must be positiv integer');
            index = 0;
            return;
        end % check if index is no integer       
    else
        % set default index (new element is last element)
        index = len + 1;
    end % check index
    
    % create a new element of class cPose
    element = cPose();
    
    % insert element in track
    if (index == 1)    
        % insert element as element 1 
        obj.track = [element obj.track];     
    elseif (index == len)  
        % insert element at position n-1
        obj.track = [obj.track(1:(index - 1)) element obj.track(len)];       
    elseif (index > len)
%         insert element as last element (n)
        obj.track = [obj.track element];
% % %         obj.track(len + 1) = [element];
% % % 
        index = len + 1;
    else
        % insert element at index
        obj.track = [obj.track(1:(index - 1)) element ...
            obj.track(index:len)];
    end

end % new_element()

