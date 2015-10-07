%% Main program

% You want to see path data in console during run? If yes set info = 1, if
% not set info = 0;
info = 1;

% Load path files
PATH = 'T_stairs_path2.csv';
SURFACE = 'T_stairs_surface.csv';

% Create objects of cTrack out of .csv-files

trackIN = cTrack(PATH);
trackSurfaceIN = cTrack(SURFACE);

% Load user input file
userInput = read_user_input('UserInputData.txt', trackIN);


%% Preparing the tracked path
if (info == 1)
    disp(' ');
    disp('START PREPARING INPUT PATH FOR GENERAL PURPOSE ...');
    disp(' ');
end

%% Plot original path

figure('name','Original path','Numbertitle','off');
trackIN.plot_track(0, 1, '-b');
grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
title('Original path');

if (info == 1)
    disp('ORIGINAL PATH');
    disp(['Number of elements: ' num2str(trackIN.number_of_elements())]);
    disp(' ');
end


%% Prefilter path

stopwatch(1);   % start stopwatch

PreFilter(trackIN, ...
    userInput.PreFilterMaxAngle, ...
    userInput.PreFilterMaxDelta, ...
    userInput.StartSphereR, ...
    userInput.EndSphereR);

fcnTime = stopwatch(0); % stop stopwatch

% Plot prefiltered path
figure('name','Prefiltered path','Numbertitle','off');
trackIN.plot_track(0, 1, '-b');
grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
title('Prefiltered path');

if (info == 1)
    disp('PREFILTERED PATH');
    disp(['Maximum Angle: ' ...
        num2str(userInput.PreFilterMaxAngle) ' °']);
    disp(['Maximum distance between two points: ' ...
        num2str(userInput.PreFilterMaxDelta) ' mm']);
    disp(['Start point filter radius: ' ...
        num2str(userInput.StartSphereR) ' mm']);
    disp(['End point filter radius: ' ...
        num2str(userInput.EndSphereR) ' mm']);
    disp(['Number of elements: ' num2str(trackIN.number_of_elements())]);
    disp(['Used time: ' num2str(fcnTime) ' s']);
    disp(' ');
end


%% Thin out path

stopwatch(1);   % start stopwatch

trackOUT = thinOut(trackIN, userInput.ThinOutAngle, ...
    userInput.ThinOutDistance, 0);

fcnTime = stopwatch(0); % stop stopwatch

% plot thined out path
figure('name', 'Thinned out path', 'Numbertitle', 'off');
trackOUT.plot_track(0, 1, '-b');
grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
title('Thined out path');

if (info == 1)
    disp('THINNED OUT PATH');
    disp(['Maximum distance tolerance: ' ...
        num2str(userInput.ThinOutDistance) ' mm']);
    disp(['Maximum angle tolerance: ' ...
        num2str(userInput.ThinOutAngle) ' °']);
    disp(['Number of elements: ' num2str(trackOUT.number_of_elements())]);
    disp(['Used time: ' num2str(fcnTime) ' s']); 
    disp(' ');
end

% Cleanup data
trackIN.delete();
trackIN = trackOUT;
clear trackOUT;


%% Interpolation of the path

stopwatch(1);   % start stopwatch

trackOUT = PathInterpolation(trackIN, userInput.T_IPO);

fcnTime = stopwatch(0); % stop stopwatch

% plot interpolated path
figure('name','Interpolated path','NumberTitle','off');
trackOUT.plot_track(0, 1, 'xb');
grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
title('Interpolated path');

if (info == 1)
    disp('INTERPOLATED PATH');
    disp(['Interpolation time: ' num2str(userInput.T_IPO) ' ms']);
    disp(['Number of elements: ' num2str(trackOUT.number_of_elements())]);
    disp(['Used time: ' num2str(fcnTime) ' s']);
    disp(' ');
end

% Cleanup data
trackIN.delete();
trackIN = trackOUT;
clear trackOUT;


%% Use case dependent functions
user = 0;
while(user == 0)
% % %     strResponse = input('\nPlease choose one of the following use cases: \nPress\n   "c" for Cutting or\n   "s" for sewing \n\n Decision : ', 's');
% % % changed for analyzer -> sewing mode always on
    strResponse = 's';
% % % 
    if(strResponse == 's')
        userInput.CuttingMode = 0;
        user = 1;
    elseif (strResponse == 'c')
        userInput.CuttingMode = 1;
        user = 1;
    else
        disp(' ');
        disp('PLEASE ENTER A CORRECT MODE!')
        disp(' ');
        user = 0;
    end
end


if (userInput.CuttingMode == 1) % Cutting mode
    if (info == 1)
        disp(' ');
        disp('ENTERING CUTTING MODE ...');
        disp(' ');
    end
    
    
    %% PREPARING OF SURFACE TRACK
    if (info == 1)
        disp('START PREPARING SURFACE TRACK ...');
        disp(' ');
    end
    
    % plot original surface
    figure('name','Original surface path','NumberTitle','off');
    trackSurfaceIN.plot_track(0, 1, '-b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Original surface path');
    
    stopwatch(1);   % start stopwatch
    
    % Prefiltering of the surface path
    PreFilter(trackSurfaceIN, ...
        userInput.PreFilterMaxAngle, ...
    	userInput.PreFilterMaxDelta, ...
        userInput.StartSphereR, ...
        userInput.EndSphereR);
        
    % Thin out ot the surface path
    trackSurfaceOUT = thinOut(trackSurfaceIN, 180, 5, 0);

    % Cleanup data
    trackSurfaceIN.delete();    
      
    fcnTime = stopwatch(0); % stop stopwatch
    
    if (info == 1)
        disp('PREPARED SURFACE TRACK');
        disp(['Number of elements: ' ...
            num2str(trackSurfaceOUT.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end

    
    %% THIN OUT SURFACE TRACK

    % Cleanup data
    trackSurfaceIN = trackSurfaceOUT;
    clear trackSurfaceOUT; 
    
    
    %% THIN OUT TRACK FOR SURFACE CALCULATION
    
    if (info == 1)
        disp('START THINNING OUT PATH ...');
        disp(' ');
    end
    
    stopwatch(1);   % start stopwatch

    trackOUT = thinOut(trackIN, userInput.ThinOutAngle, ...
        3, 0);
    
    fcnTime = stopwatch(0); % stop stopwatch
    
    % plot thined out path
    figure('name','Thined out path','NumberTitle','off');
    trackOUT.plot_track(0, 1, '-b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Thined out path');
    
    if (info == 1)
        disp('THINNED OUT PATH');
        disp(['Maximum distance tolerance: ' ...
            num2str(userInput.ThinOutDistance) ' mm']);
        disp(['Maximum angle tolerance: ' ...
            num2str(userInput.ThinOutAngle) ' °']);
        disp(['Number of elements: ' ...
            num2str(trackOUT.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end
    
    % Cleanup data
    trackIN.delete();
    trackIN = trackOUT;
    clear trackOUT;
    
    
    %% START CALCULATING SURFACE NORMAL
    if (info == 1)
        disp('START CALCULATING SURFACE NORMAL ...');
        disp(' ');
    end
    
    stopwatch(1); % start stopwatch
    
    SurfaceNormal( trackSurfaceIN, trackIN );
    
    fcnTime = stopwatch(0); % stop stopwatch

    figure('name','Surface normal set path','NumberTitle','off');
    trackIN.plot_track(1, 0.5, 'b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Surface normal set path');
    
    if (info == 1)
        disp('SURFACE NORMAL SET PATH');
        disp(['Number of elements: ' ...
            num2str(trackIN.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' '); 
    end

    if (info == 1)
        disp('START ADAPTING ORIENTATION FOR SEWING MODE ...');
        disp(' ');
    end
    
    stopwatch(1); % start stopwatch

    trackIN = SetOrientation(trackIN, userInput.CuttingMode, ...
                userInput.ConstAngleCutting);
    
    fcnTime = stopwatch(0); % stop stopwatch
    
    figure('name','Orientation set path','NumberTitle','off');
    trackIN.plot_track(1, 0.5, 'b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Orientation set path');
    
    if (info == 1)
        disp('ORIENTATION SET PATH');
        disp(['Number of elements: ' ...
            num2str(trackIN.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' '); 
    end

    
    %% GENERATE KRL-PROGRAM
    
    if (info == 1)
        disp('START CREATING KRL PROGRAM ...');
        disp(' ');
    end
    
    stopwatch(1); % start stopwatch
    
    % create KRL program
    KRLProgram(trackIN, ...
        trackIN.number_of_elements, ...
        userInput.FlyByRadius, ...
        userInput.PathSpeed);
    
    fcnTime = stopwatch(0); % stop stopwatch
    
    
    %% Write interpolated path into a csv file
    write_to_file(trackIN, 'KRL');
    
    % plot final path
    figure('name','Final path for KRL program','Numbertitle','off');
    trackIN.plot_track(1, 0.5, 'b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Final path for KRL program');
    
    if (info == 1)
        disp('FINAL PATH FOR KRL PROGRAM');
        disp(['Number of elements: ' ...
            num2str(trackIN.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end
    
    
elseif (userInput.CuttingMode == 0) % Sewing mode
    
    if (info == 1)
        disp(' ');
        disp('ENTERING SEWING MODE ...');
        disp(' ');
    end

    
    %% PREPARING OF SURFACE TRACK
    if (info == 1)
        disp('START PREPARING SURFACE TRACK ...');
        disp(' ');
    end
    
    % plot original surface
    figure('name','Original surface path','NumberTitle','off');
    trackSurfaceIN.plot_track(0, 1, '-b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Original surface path');
    
    stopwatch(1); % start stopwatch
    
    % Prefiltering of the surface path
    PreFilter(trackSurfaceIN, ...
        userInput.PreFilterMaxAngle, ...
    	userInput.PreFilterMaxDelta, ...
        userInput.StartSphereR, ...
    	userInput.EndSphereR);
        
    % Thin out ot the surface path
    trackSurfaceOUT = thinOut(trackSurfaceIN, 180, 5, 0);

    % Cleanup data
    trackSurfaceIN.delete();
      
    fcnTime = stopwatch(0); % stop stopwatch
    
    if (info == 1)
        disp('PREPARED SURFACE TRACK');
        disp(['Number of elements: ' ...
            num2str(trackSurfaceOUT.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end    

  
    % Cleanup data
    trackSurfaceIN = trackSurfaceOUT;
    clear trackSurfaceOUT;
    
    
    %% THIN OUT TRACK FOR SURFACE CALCULATION
    if (info == 1)
        disp('START THINNING OUT PATH ...');
        disp(' ');
    end
       
    stopwatch(1); % start stopwatch

    trackOUT = thinOut(trackIN, userInput.ThinOutAngle , ...
        3, 0);

    fcnTime = stopwatch(0); % stop stopwatch
    
    % plot thined out path
    figure('name','Thined out path','NumberTitle','off');
    trackOUT.plot_track(0, 1, '-b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Thined out path');

    if (info == 1)
        disp('THINNED OUT PATH');
        disp(['Maximum distance tolerance: ' ...
            num2str(userInput.ThinOutDistance) ' mm']);
        disp(['Maximum angle tolerance: ' ...
            num2str(userInput.ThinOutAngle) ' °']);
        disp(['Number of elements: ' ...
            num2str(trackOUT.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end
    
    % Cleanup data
    trackIN.delete();
    trackIN = trackOUT;
    clear trackOUT;

    
    %% START CALCULATING SURFACE NORMAL
    if (info == 1)
        disp('START CALCULATING SURFACE NORMAL ...');
        disp(' ');
    end
    
    stopwatch(1); % start stopwatch
    
    SurfaceNormal(trackSurfaceIN, trackIN);
    
    fcnTime = stopwatch(0); % stop stopwatch

    figure('name','Surface normal set path','NumberTitle','off');
    trackIN.plot_track(1, 0.5, 'b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Surface normal set path');
    
    if (info == 1)
        disp('SURFACE NORMAL SET PATH');
        disp(['Number of elements: ' ...
            num2str(trackIN.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end

    if (info == 1)
        disp('START ADAPTING ORIENTATION FOR SEWING MODE ...');
        disp(' ');
    end
    
    stopwatch(1); % start stopwatch

    trackIN = SetOrientation(trackIN, userInput.CuttingMode, ...
                userInput.ConstAngleCutting);
    
    fcnTime = stopwatch(0); % stop stopwatch
    
    figure('name','Orientation set path','NumberTitle','off');
    trackIN.plot_track(1, 0.5, 'b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Orientation set path');
    
    if (info == 1)
        disp('ORIENTATION SET PATH');
        disp(['Number of elements: ' ...
            num2str(trackIN.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end
    
    %% INTERPOLATION FOR RSI
    
    if (info == 1)
        disp('START INTERPOLATING PATH FOR RSI ...');
        disp(' ');
    end
    
    stopwatch(1); % start stopwatch
    
    % interpolation
    trackIN = PathInterpolation(trackIN, userInput.T_IPO);
    
    fcnTime = stopwatch(0); % stop stopwatch
    
    % plot final path
    figure('name','Final path for RSI','Numbertitle','off');
    trackIN.plot_track(1, 0.5, 'b');
    grid; xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    title('Final path for RSI');
    
    if (info == 1)
        disp('FINAL PATH FOR RSI');
        disp(['Interpolation time: ' num2str(userInput.T_IPO) ' ms']);
        disp(['Number of elements: ' ...
            num2str(trackIN.number_of_elements())]);
        disp(['Used time: ' num2str(fcnTime) ' s']);
        disp(' ');
    end
    
    %% Write interpolated path into a csv file
    write_to_file(trackIN, 'Interpolation_T_IPO');
    
else
    disp(' ');
    disp('Wrong use case mode!');
    disp(' ');
end
% strName = input('Do you want to save path in a .csv-file?\n Press:\n   "y" for yes and\n "n" for no','s')

% % % input('\nPress ENTER to finish program ...');

% % % changed for analyzer program closes automatically







