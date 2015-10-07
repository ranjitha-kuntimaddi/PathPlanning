% Function name: isRotmatzero
% Function to check if rotation matrix is zero (empty)
% Input:
%       rotmat:         Rotation matrix whose get checked
% Output:
%       equal:          True if rotation matrix is zero, false if not

function [equal] = isRotmatzero(rotmat)

%Checks every element in the rotation matrix
for i=1:9
    %If one elemnt is unequal to zero 
    if (rotmat(i) ~= 0)
        equal = 0;      %The return value gets false
        break;          %And the checking stopps
    else                
        equal = 1;      %If every element is zero the return value keeps true
    end
end

end % end of isRotmatzero