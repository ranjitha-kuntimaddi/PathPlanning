function varargout = rapid_prototyp_edit_v2(varargin)
% RAPID_PROTOTYP_EDIT_V2 MATLAB code for rapid_prototyp_edit_v2.fig
%      RAPID_PROTOTYP_EDIT_V2, by itself, creates a new RAPID_PROTOTYP_EDIT_V2 or raises the existing
%      singleton*.
%
%      H = RAPID_PROTOTYP_EDIT_V2 returns the handle to a new RAPID_PROTOTYP_EDIT_V2 or the handle to
%      the existing singleton*.
%
%      RAPID_PROTOTYP_EDIT_V2('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RAPID_PROTOTYP_EDIT_V2.M with the given input arguments.
%
%      RAPID_PROTOTYP_EDIT_V2('Property','Value',...) creates a new RAPID_PROTOTYP_EDIT_V2 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before rapid_prototyp_edit_v2_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to rapid_prototyp_edit_v2_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help rapid_prototyp_edit_v2

% Last Modified by GUIDE v2.5 26-May-2013 22:19:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @rapid_prototyp_edit_v2_OpeningFcn, ...
                   'gui_OutputFcn',  @rapid_prototyp_edit_v2_OutputFcn, ...
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


% --- Executes just before rapid_prototyp_edit_v2 is made visible.
function rapid_prototyp_edit_v2_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to rapid_prototyp_edit_v2 (see VARARGIN)

% Choose default command line output for rapid_prototyp_edit_v2
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes rapid_prototyp_edit_v2 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = rapid_prototyp_edit_v2_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Status;
global LastState;

%Return to GUI

Status.State=LastState;
delete(handles.figure1);