% Function name: KRLProgram
% Function to write a KRL program 
% it creates a file by name of KRL_Prog.src which contains the commands for
% the robot and a KRL_Prog.dat file with the KUKA settings,
% which is necessary for the robot  
%
% Input: 
% 		n:   number of points of the path
% 		r:   Fly by radius
% 		v:   velocity 
% 		obj: the path-data for the robot-movement (TrackIN)
% Output:
%		two files are written (KRL_Prog.src & KRL_Prog.dat)

function KRLProgram(obj,n,r,v)

fid= fopen('KRL_Prog.src','wt');    % create a .src file named 'KRL_Prog.src'

% Print the necessary KUKA-settings into the .src file
fprintf(fid,'&ACCESS RVP\n');
fprintf(fid,'&REL 134\n');
fprintf(fid,'&PARAM TEMPLATE = C:\\KRC\\Roboter\\Template\\vorgabe\n');
fprintf(fid,'&PARAM EDITMASK = *\n');
fprintf(fid,'DEF baumerbalance( )\n');
fprintf(fid,'DECL RSIERR err\n');
fprintf(fid,';FOLD INI\n');
fprintf(fid,'  ;FOLD BASISTECH INI\n');
fprintf(fid,'    GLOBAL INTERRUPT DECL 3 WHEN $STOPMESS==TRUE DO IR_STOPM ( )\n');
fprintf(fid,'    INTERRUPT ON 3 \n');
fprintf(fid,'    BAS (#INITMOV,0 )\n');
fprintf(fid,'  ;ENDFOLD (BASISTECH INI)\n');
fprintf(fid,'  ;FOLD USER INI\n');
fprintf(fid,'    ;Make your modifications here\n\n');
fprintf(fid,'  ;ENDFOLD (USER INI)\n');
fprintf(fid,';ENDFOLD (INI)\n\n');

%% CALCULATION

change = 0;     % variable to check if fly by radius changed
r_new = r;      % variable to store the changed fly by radius (at beginning = r)

% get the three vectors to calculate the two distances
P1vec = [obj.get_vector(1)];   % to get vector for point 1 
P2vec = [obj.get_vector(2)];   % to get vector for point 2
P3vec = [obj.get_vector(3)];   % to get vector for point 3

% get the three euler-angles for the first point
eulerangles = zeros(3,1);      % create zero 3x1 matrix to store the euler-angles
[eulerangles(1,1),eulerangles(2,1),eulerangles(3,1)] = getEulerAngles(obj, 1);
% store the three euler-angles in the matrix

%fprintf(fid,'PTP HOME\n');    % print the home position command
fprintf(fid,'$APO.CVEL=%.0f\n',v);   % print the set-command for the velocity
fprintf(fid,'$APO.CDIS=%.0f\n',r);   % print the set-command for the fly by radius 

% print the move-command to the first point of the path
fprintf(fid,'PTP {X %.3f, Y %.3f, Z %.3f, A %.3f, B %.3f, C %.3f}\n',...
    P1vec,eulerangles(1,1),eulerangles(2,1),eulerangles(3,1));      

%% LOOP for calculating and printing the other points 
for i=4:n
    
    % check up for fly-by radius
    l1 = norm(P1vec-P2vec); % calculate the distance between the points P1 and P2 
    l2 = norm(P2vec-P3vec); % calculate the distance between the points P2 and P3
   
    % check which distance is smaller
    if (l1 <= l2)           % if l1 is smaller than l2
        if (l1/2 < r)&&(l1/2 ~= r_new)  % if the half distance between P1 and P2 is smaller than the user-input-radius
                                        % !and! the new distance is unequal the last changed radius
            fprintf(fid,'$APO.CDIS = %.3f\n',l1/2); % print the set-command with new radius l1/2
            change = 1;     % radius has changed
            r_new = l1/2;   % store the new radius in r_new
        end
        if (l1/2 > r)&&(change == 1)    % if the half distance between P1 and P2 is bigger than the user-input-radius
                                        % !and! the radius was changed from the user-input-radius
            fprintf(fid,'$APO.CDIS = %.3f\n',r);    % print the set-command with the user-input-radius
            change = 0;     % radius changed back to user-input
        end
        
    else                    % if l2 is smaller than l1
        if (l2/2 < r)&&(l2/2 ~= r_new)  % if the half distance between P2 and P3 is smaller than the user-input-radius
                                        % !and! the new distance is unequal the last changed radius
            fprintf(fid,'$APO.CDIS = %.3f\n',l2/2); % print the set-command with new radius l2/2
            change = 1;     % radius has changed
            r_new = l2/2;   % store the new radius in r_new
        end
        if (l2/2 > r)&&(change == 1)    % if the half distance between P2 and P3 is bigger than the user-input-radius
                                        % !and! the radius was changed from the user-input-radius
            fprintf(fid,'$APO.CDIS = %.3f\n',r);    % print the set-command with the user-input-radius
            change = 0;     % radius changed back to user-input
        end
    end
    
    % get the next points in the path  
    P1vec = P2vec;    
    P2vec = P3vec;   
    P3vec = [obj.get_vector(i)];
    
    % Calculation of the euler angles
    [eulerangles(1,1),eulerangles(2,1),eulerangles(3,1)] = getEulerAngles(obj, i-2);
    
    % print the move-command to the next point in the row
    fprintf(fid,'LIN {X %.3f, Y %.3f, Z %.3f, A %.3f, B %.3f, C %.3f} C_DIS\n',...
    P1vec,eulerangles(1,1),eulerangles(2,1),eulerangles(3,1));

end % end of the loop, if i equals n (number of points in the path)

%% prints the last two points of the path

% get the euler angles of the second to last point of the path
[eulerangles(1,1),eulerangles(2,1),eulerangles(3,1)] = getEulerAngles(obj, n-1);

% print the move-command to the second to last point of the path
fprintf(fid,'LIN {X %.3f, Y %.3f, Z %.3f, A %.3f, B %.3f, C %.3f} C_DIS\n',...
    P2vec,eulerangles(1,1),eulerangles(2,1),eulerangles(3,1));

% get the euler angles of the second to last point of the path
[eulerangles(1,1),eulerangles(2,1),eulerangles(3,1)] = getEulerAngles(obj, n);

% print the move-command to the point of the path
fprintf(fid,'LIN {X %.3f, Y %.3f, Z %.3f, A %.3f, B %.3f, C %.3f} C_DIS\n',...
    P3vec,eulerangles(1,1),eulerangles(2,1),eulerangles(3,1));

%fprintf(fid,'PTP HOME\n');    % go to home position 
fprintf(fid,'\nEND');          % end the program 

fclose(fid);                   % close the .src file 

%% create a .dat file named 'KRL_Prog.dat'
fid2= fopen('KRL_Prog.dat','wt');   

% Print the necessary KUKA-settings into the .dat file
fprintf(fid2,'&ACCESS RVP\n');
fprintf(fid2,'&REL 134\n');
fprintf(fid2,'&PARAM TEMPLATE = C:\\KRC\\Roboter\\Template\\vorgabe\n');
fprintf(fid2,'&PARAM EDITMASK = *\n');
fprintf(fid2,'DEFDAT  BAUMERBALANCE\n');
fprintf(fid2,';FOLD EXTERNAL DECLARATIONS;%%{PE}%%MKUKATPBASIS,%%CEXT,%%VCOMMON,%%P\n');
fprintf(fid2,';FOLD BASISTECH EXT;%%{PE}%%MKUKATPBASIS,%%CEXT,%%VEXT,%%P\n');
fprintf(fid2,'EXT  BAS (BAS_COMMAND  :IN,REAL  :IN )\n');
fprintf(fid2,'DECL INT SUCCESS\n');
fprintf(fid2,';ENDFOLD (BASISTECH EXT)\n');
fprintf(fid2,';FOLD USER EXT;%%{E}%%MKUKATPUSER,%%CEXT,%%VEXT,%%P\n');
fprintf(fid2,';Make here your modifications\n\n');
fprintf(fid2,';ENDFOLD (USER EXT)\n');
fprintf(fid2,';ENDFOLD (EXTERNAL DECLERATIONS)\n\n');
fprintf(fid2,'ENDDAT');

fclose(fid2);   % close the .dat file

end % end of KRLprogram