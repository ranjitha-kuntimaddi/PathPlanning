function varargout = rapid_prototyp_v2(varargin)
% RAPID_PROTOTYP_V2 MATLAB code for rapid_prototyp_v2.fig
%      RAPID_PROTOTYP_V2, by itself, creates a new RAPID_PROTOTYP_V2 or raises the existing
%      singleton*.
%
%      H = RAPID_PROTOTYP_V2 returns the handle to a new RAPID_PROTOTYP_V2 or the handle to
%      the existing singleton*.
%
%      RAPID_PROTOTYP_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAPID_PROTOTYP_V2.M with the given input arguments.
%
%      RAPID_PROTOTYP_V2('Property','Value',...) creates a new RAPID_PROTOTYP_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rapid_prototyp_v2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rapid_prototyp_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rapid_prototyp_v2

% Last Modified by GUIDE v2.5 07-Jun-2013 18:50:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rapid_prototyp_v2_OpeningFcn, ...
                   'gui_OutputFcn',  @rapid_prototyp_v2_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before rapid_prototyp_v2 is made visible.
function rapid_prototyp_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rapid_prototyp_v2 (see VARARGIN)

% Choose default command line output for rapid_prototyp_v2
handles.output = hObject;

set(handles.text2, 'String', 'Waiting for user interaction');
set(handles.text2, 'BackgroundColor', 'green');

set(handles.pushbutton1, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.pushbutton4, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.pushbutton5, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.pushbutton7, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.pushbutton9, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.pushbutton8, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.tag_send_path, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.delete_data_tag, 'ForegroundColor', [0.5 0.5 0.5]);
set(handles.save_data_tag, 'ForegroundColor', [0.5 0.5 0.5]);

axes(handles.axes1);
grid on;
rotate3d on;

axes(handles.axes2);
grid on;
rotate3d on;


% Update handles structure
guidata(hObject, handles);


% UIWAIT makes rapid_prototyp_v2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rapid_prototyp_v2_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%Prototyps of the global variables
global Definitions;
global Settings;
global Status;
global trackIN;
global trackSurfaceIN;

% Check for path data availability
if (Status.State==Definitions.OrigDataLoaded)
    
    %%Preperation of the path
    % Setting the state of the GUI
    Status.State=Definitions.Running;
    set(handles.pushbutton6, 'ForegroundColor', [0.5 0.5 0.5]);
    set(handles.pushbutton1, 'ForegroundColor', [0.5 0.5 0.5]);
    
    % Setting Status indicator
    set(handles.text2, 'String', 'Preparation running');
    set(handles.text2, 'BackgroundColor', 'red');
    uiwait(handles.figure1, 1);
    
    % Prefiltering of the path
    % Setting of the preperation porgress indicator
    set(handles.listbox1,'Value',1);
    uiwait(handles.figure1, 1);
    
    % Wait for input in step by step mode and setting of the status
    % indicator
    if (Settings.PreparationMode==Definitions.StepbyStep)
        set(handles.text2, 'String', 'Waiting for user interaction');
        set(handles.text2, 'BackgroundColor', 'green');  
        set(handles.pushbutton4, 'ForegroundColor', 'black');
        uiwait;
        set(handles.pushbutton4, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.text2, 'String', 'Preparation running');
        set(handles.text2, 'BackgroundColor', 'red');
        uiwait(handles.figure1, 1);
    end
    
    % Choice between the prefiltering algorithms
    if (Settings.Prefiltering==Definitions.DefaultFiltering)
        PreFilter(trackIN, ...
            Settings.PreFilterMaxAngle, ...
            Settings.PreFilterMaxDelta, ...
            Settings.StartSphereR, ...
            Settings.EndSphereR);
    end
      
    % Thin out of the path
    % Setting of the preperation porgress indicator
    set(handles.listbox1,'Value',2);
    uiwait(handles.figure1, 1);
    
    % Plot of the prefiltered path ,wait for input in step by step mode and setting of the status
    % indicator
    if (Settings.PreparationMode==Definitions.StepbyStep)
        axes(handles.axes2);
        trackIN.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
        xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
        
        set(handles.text2, 'String', 'Waiting for user interaction');
        set(handles.text2, 'BackgroundColor', 'green');
        set(handles.pushbutton4, 'ForegroundColor', 'black');
        uiwait;
        set(handles.pushbutton4, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.text2, 'String', 'Preparation running');
        set(handles.text2, 'BackgroundColor', 'red');
        uiwait(handles.figure1, 1);
    end
    
    % Choice between the thin out algorithms
    if (Settings.ThinOut==Definitions.DistanceAlgorithm)
        trackOUT = thinOut(trackIN, Settings.ThinOutAngle, ...
        Settings.ThinOutDistance, 0);
        
        % Cleanup data
        trackIN = trackOUT;
        clear trackOUT;
    end
   
    % Interpolation of the path
    % Setting of the preperation porgress indicator
    set(handles.listbox1,'Value',3);
    uiwait(handles.figure1, 1);
    
    % Plot of the thinned out path, wait for input in step by step mode and setting of the status
    % indicator
    if (Settings.PreparationMode==Definitions.StepbyStep)
        axes(handles.axes2);
        cla;
        trackIN.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
        xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
        
        set(handles.text2, 'String', 'Waiting for user interaction');
        set(handles.text2, 'BackgroundColor', 'green');
        set(handles.pushbutton4, 'ForegroundColor', 'black');
        uiwait;
        set(handles.pushbutton4, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.text2, 'String', 'Preparation running');
        set(handles.text2, 'BackgroundColor', 'red');
        uiwait(handles.figure1, 1);
    end
    
    % Choice between the interpolation algorithms
    if (Settings.Interpolation==Definitions.LinearInterpolation)
        trackOUT = PathInterpolation(trackIN, Settings.T_IPO);
  
        % Cleanup data
        trackIN = trackOUT;
        clear trackOUT;
    end
    
    %% Adaption of the orientation
    % Setting of the preperation porgress indicator
    set(handles.listbox1,'Value',4);
    uiwait(handles.figure1, 1);
    
    % Plot of the interpolated path, wait for input in step by step mode and setting of the status
    % indicator
    if (Settings.PreparationMode==Definitions.StepbyStep)
        axes(handles.axes2);
        cla;
        trackIN.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
        xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
        
        set(handles.text2, 'String', 'Waiting for user interaction');
        set(handles.text2, 'BackgroundColor', 'green');
        set(handles.pushbutton4, 'ForegroundColor', 'black');
        uiwait;
        set(handles.pushbutton4, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.text2, 'String', 'Preparation running');
        set(handles.text2, 'BackgroundColor', 'red');
        uiwait(handles.figure1, 1);
    end
    
    % Choice between the use cases
    if (Settings.UseCase==Definitions.CuttingMode)
        
        % Prefiltering of the surface path
        % Choice between the prefiltering algorithms
        if (Settings.Prefiltering==Definitions.DefaultFiltering)
            PreFilter(trackSurfaceIN, ...
                Settings.PreFilterMaxAngle, ...
                Settings.PreFilterMaxDelta, ...
                Settings.StartSphereR, ...
                Settings.EndSphereR);
        end
        
        % Thin out of the surface path
        % Choice between the thin out algorithms
        if(Settings.ThinOut==Definitions.DistanceAlgorithm)
            trackSurfaceOUT = thinOut(trackSurfaceIN, 180, 5, 0);

            % Cleanup data 
            trackSurfaceIN = trackSurfaceOUT;
            clear trackSurfaceOUT;
   
            % Thin out track for surface calculation
            trackOUT = thinOut(trackIN, Settings.ThinOutAngle, ...
            3, 0);
    
            % Cleanup data
            trackIN = trackOUT;
            clear trackOUT;
        end
    
        % Calculation of surface normal
        SurfaceNormal( trackSurfaceIN, trackIN );

        % Adaption of orientation for cutting mode
        trackIN = SetOrientation(trackIN, Settings.CuttingMode, ...
                Settings.ConstAngleCutting);
    
        % Generation of the KRL-PROGRAM
        KRLProgram(trackIN, ...
            trackIN.number_of_elements, ...
            Settings.FlyByRadius, ...
            Settings.PathSpeed);
         
    elseif (Settings.UseCase==Definitions.SewingMode)
        
        % Prefiltering of the surface path
        % Choice between the prefiltering algorithms
        if (Settings.Prefiltering==Definitions.DefaultFiltering)
            PreFilter(trackSurfaceIN, ...
                Settings.PreFilterMaxAngle, ...
                Settings.PreFilterMaxDelta, ...
                Settings.StartSphereR, ...
                Settings.EndSphereR);
        end

        % Thin out of the surface path
        % Choice between the thin out algorithms
        if (Settings.ThinOut==Definitions.DistanceAlgorithm)
            trackSurfaceOUT = thinOut(trackSurfaceIN, 180, 5, 0);

            % Cleanup data
            trackSurfaceIN = trackSurfaceOUT;
            clear trackSurfaceOUT;
    
            % Thin out track for surface calculation
            trackOUT = thinOut(trackIN, Settings.ThinOutAngle , ...
            3, 0);

            % Cleanup data
            trackIN = trackOUT;
            clear trackOUT;
        end

    
        % Calculation of surface normal
        SurfaceNormal(trackSurfaceIN, trackIN);

        % Adaption of orientation for sewing mode
        trackIN = SetOrientation(trackIN, Settings.CuttingMode, ...
                Settings.ConstAngleCutting);

        % Interpolation for RSI
        % Choice between the interpolation algorithms
        if (Settings.Interpolation==Definitions.LinearInterpolation)
            trackIN = PathInterpolation(trackIN, Settings.T_IPO);
        end
    end
    
    % Plot final path
    axes(handles.axes2);
    cla;
    trackIN.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
    xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    grid on; 
    rotate3d on;
    
    % Setting the state of the GUI
    Status.State=Definitions.PathPrepared;
    
    % Setting of the status indicator
    set(handles.text2, 'String', 'Waiting for user interaction');
    set(handles.text2, 'BackgroundColor', 'green');
    set(handles.pushbutton1, 'ForegroundColor', [0.5 0.5 0.5]);
    set(handles.pushbutton4, 'ForegroundColor', [0.5 0.5 0.5]);
    set(handles.pushbutton6, 'ForegroundColor', [0.5 0.5 0.5]);
    set(handles.pushbutton5, 'ForegroundColor', 'black');
    set(handles.pushbutton7, 'ForegroundColor', 'black');
    set(handles.pushbutton9, 'ForegroundColor', 'black');
    set(handles.pushbutton8, 'ForegroundColor', 'black');
    set(handles.save_data_tag, 'ForegroundColor', 'black');
    
    % Pop up error message
    msgbox('Preparation finished','Message','non')
    
% Check for the preperation status
elseif (Status.State==Definitions.Running)
    
    % Pop up error message
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.SimulationDone)
    
    % Pop up error message
    msgbox('Simulation already done','Error','warn')
    
elseif (Status.State==Definitions.PathPrepared)

    % Pop up error message
    msgbox('Path already prepared','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')

else
    
    % Pop up error message
    msgbox('No Data available','Error','warn')
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;
global Settings;

if(Status.State==Definitions.Running&&Settings.PreparationMode==Definitions.StepbyStep)
    
    %Resume the preperation of path
    uiresume;
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')

    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')

    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
else
    
    % Pop up error message
    msgbox('Preperation not started','Error','warn')

end

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;

if(Status.State==Definitions.PathPrepared)
    
    %Code for the simualation
    
    % Setting the state of the GUI
    Status.State=Definitions.SimulationDone;
       
    % Setting of the status indicator
    set(handles.pushbutton5, 'ForegroundColor',[0.5 0.5 0.5]);
    set(handles.pushbutton9, 'ForegroundColor',[0.5 0.5 0.5]);
    set(handles.tag_send_path, 'ForegroundColor', 'black');
    
    % Pop up error message
    msgbox('Not yet implemented','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')

elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
else
    
    % Pop up error message     
    msgbox('No prepared path available','Error','warn')
end

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;
global LastState;

% Check for legal state
if(Status.State==Definitions.OrigDataNotLoaded||Status.State==Definitions.OrigDataLoaded)
    
    %Setting the state of the GUI
    LastState=Status.State;
    Status.State=Definitions.Setting;
    
    %Call of the settings interface
    rapid_prototyp_settings_v2;
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
else
    
    % Pop up error message
    msgbox('Path already prepared','Error','warn')
end

% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;
global trackORIG;
global trackIN;

if(Status.State==Definitions.OrigDataLoaded||Status.State==Definitions.PathPrepared||Status.State==Definitions.SimulationDone)
    
    if (Status.TrackAppearance==Definitions.Dots)
        Status.TrackAppearance=Definitions.Graph;
    else
        Status.TrackAppearance=Definitions.Dots;
    end
    
    % Plot the original path
    axes(handles.axes1);
    cla;
    trackORIG.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
    xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    grid on; 
    rotate3d on;
    
    if (Status.State==Definitions.PathPrepared||Status.State==Definitions.SimulationDone)
        % Plot the prepared path
        axes(handles.axes2);
        cla;
        trackIN.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
        xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    end
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
else
    
    % Pop up error message
    msgbox('No data available','Error','warn')
end

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;
global trackORIG;
global trackIN;

if(Status.State==Definitions.OrigDataLoaded||Status.State==Definitions.PathPrepared||Status.State==Definitions.SimulationDone)
    
    if (Status.PlotDimensions==Definitions.ThreeD)
        Status.PlotDimensions=Definitions.SixD;
    else
        Status.PlotDimensions=Definitions.ThreeD;
    end
    
    % Plot the original path
    axes(handles.axes1);
    cla;
    trackORIG.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
    xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    grid on; 
    rotate3d on;
    
    if (Status.State==Definitions.PathPrepared||Status.State==Definitions.SimulationDone)
        % Plot the prepared path
        axes(handles.axes2);
        cla;
        trackIN.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
        xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');
    end
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
else
    
    % Pop up error message
    msgbox('No data available','Error','warn')
end

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;
global LastState;

if (Status.State==Definitions.PathPrepared)
    
    %Setting the state of the GUI
    LastState=Status.State;
    Status.State=Definitions.Edit;
    
    %Open of the track editor
    rapid_prototyp_edit_v2;

elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
elseif (Status.State==Definitions.Running)

    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.SimulationDone)
    
    % Pop up error message
    msgbox('Simulation already done','Error','warn')
    
else
    
    % Pop up error message
    msgbox('No prepared path available','Error','warn')
end

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns listbox1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from listbox1


% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function file_tag_Callback(hObject, eventdata, handles)
% hObject    handle to file_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function get_data_tag_Callback(hObject, eventdata, handles)
% hObject    handle to get_data_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Definitions;
global Status;
global trackIN;
global trackSurfaceIN;
global trackORIG;

if (Status.State==Definitions.OrigDataNotLoaded)
    
    % Setting the state of the GUI
    Status.State=Definitions.Running;
    
    % Pop up error message
    set(handles.text2, 'String', 'Loading data');
    set(handles.text2, 'BackgroundColor', 'red');
    set(handles.get_data_tag, 'ForegroundColor', [0.5 0.5 0.5]);
    uiwait(handles.figure1, 1);
    
    
    % Load path files
    [data_name_path, data_path_path]=uigetfile('*.csv','OPEN PATH DATA');
    [data_name_surface, data_path_surface]=uigetfile('*.csv','OPEN SURFACE DATA');
    PATH = [data_path_path data_name_path];
    SURFACE = [data_path_surface data_name_surface];

    % Create objects of cTrack out of .csv-file
    trackORIG=cTrack(PATH);
    trackIN = trackORIG;
    trackSurfaceIN = cTrack(SURFACE);

    % Plot the original path
    axes(handles.axes1);
    trackORIG.plot_track(Status.PlotDimensions, 1, Status.TrackAppearance);
    xlabel('x[mm]'); ylabel('y[mm]'); zlabel('z[mm]');

    % Setting the state of the GUI
    Status.State=Definitions.OrigDataLoaded;
    
    % Setting of the status indicator
    set(handles.text2, 'String', 'Waiting for user interaction');
    set(handles.text2, 'BackgroundColor', 'green');
    set(handles.pushbutton6, 'ForegroundColor', 'black');
    set(handles.pushbutton1, 'ForegroundColor', 'black');
    set(handles.delete_data_tag, 'ForegroundColor', 'black');
    set(handles.get_data_tag, 'ForegroundColor', [0.5 0.5 0.5]);
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
else
    
    % Pop up error message
    msgbox('Data already loaded','Error','warn')
end
% --------------------------------------------------------------------
function save_data_tag_Callback(hObject, eventdata, handles)
% hObject    handle to save_data_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Setting of the status indicator
% PreviousStatus=get(handles.text2, 'String');
% set(handles.text2, 'String', 'Error - Not yet implemented');
% uiwait(handles.figure1, 1);
% set(handles.text2, 'String', PreviousStatus);
% uiwait;

global trackIN;
global trackSurfaceIN;
global Status;
global Definitions;

if (Status.State==Definitions.PathPrepared||Status.State==Definitions.SimulationDone)
   
    %Ask if realy want to save
    choice = questdlg('You really want to save?','Save','Yes','No ','No ');

    %YES
    if (choice == 'Yes')
        try
            %Get the name of file
            [saveNamePath]=uiputfile('*.csv','Save Path Workspace As');
            [saveNameSurface]=uiputfile('*.csv','Save Surface Workspace As'); 
            %wirte data in file
            write_to_file(trackIN, saveNamePath);
            write_to_file(trackSurfaceIN, saveNameSurface);
            % Pop up error message  
            msgbox('Data saved','Message','none')
        catch
            % Pop up error message  
            msgbox('Save process failed','Error','error')
        end
    end
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
else
    
    % Pop up error message
    msgbox('No prepared path available','Error','warn')
end
% --------------------------------------------------------------------
function close_tag_Callback(hObject, eventdata, handles)
% hObject    handle to close_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Close of the GUI
choice = questdlg('Do you really want to close?','Close','Yes','No ','No ');

if (choice == 'Yes')
    delete(handles.figure1);
    clc;
    clear all;
    close all;
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --------------------------------------------------------------------
function delete_data_tag_Callback(hObject, eventdata, handles)
% hObject    handle to delete_data_tag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;
global trackIN;
global trackORIG;
global trackSurfaceIN;

if (Status.State==Definitions.OrigDataNotLoaded)
    
    % Pop up error message
    msgbox('No data available','Error','warn')
    
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')
    
else
    
    %Ask if realy want to delet
    choice = questdlg('Do you really want to delete?','Delet','Yes','No ','No ');

    %YES
    if (choice == 'Yes')
    
        % Clear original path and prepared path
        axes(handles.axes1);
        cla;
        axes(handles.axes2);
        cla;
    
        trackIN.delete();
        trackORIG.delete();
        trackSurfaceIN.delete();
    
        % Setting the state of the GUI
        Status.State=Definitions.OrigDataNotLoaded;
    
        % Setting of the preperation porgress indicator
        set(handles.listbox1,'Value',1);
        set(handles.pushbutton6, 'ForegroundColor', 'black');
        set(handles.pushbutton1, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.pushbutton4, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.pushbutton5, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.pushbutton7, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.pushbutton9, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.pushbutton8, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.tag_send_path, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.delete_data_tag, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.save_data_tag, 'ForegroundColor', [0.5 0.5 0.5]);
        set(handles.get_data_tag, 'ForegroundColor', 'black');
        uiwait(handles.figure1, 1);
        
        % Pop up error message
        msgbox('Data deleted','Message','non')
    end
end


% --------------------------------------------------------------------
function tag_robot_Callback(hObject, eventdata, handles)
% hObject    handle to tag_robot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tag_send_path_Callback(hObject, eventdata, handles)
% hObject    handle to tag_send_path (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global Definitions;
global Settings;
global trackIN;

% Check for prepared path availability
if(Status.State==Definitions.SimulationDone)
    
    if (Settings.UseCase==Definitions.CuttingMode)
        % Write interpolated path into a csv file
        write_to_file(trackIN,[Settings.ProgName '_KRL']);
    
        % Pop up error message
        msgbox('KRL program generated','Message','non')
        
    else
        % Write interpolated path into a csv file
        write_to_file(trackIN,[Settings.ProgName '_RSI']);

        % Pop up error message
        msgbox('RSI program generated','Message','non')
    end
        
elseif (Status.State==Definitions.Running)
    
    % Pop up error message     
    msgbox('Preperation is running','Error','warn')
    
elseif (Status.State==Definitions.Edit)
    
    % Pop up error message
    msgbox('Editor opened','Error','warn')
    
elseif (Status.State==Definitions.Setting)
    
    % Pop up error message
    msgbox('Settings interface opened','Error','warn')

else
    
    % Pop up error message
    msgbox('Simulation not runned','Error','warn')
end


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function tag_help_help_Callback(hObject, eventdata, handles)
% hObject    handle to tag_help_help (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

msgbox('Step 1: Load data''Step 2: Set settings','HELP','help')
