function varargout = Interface(varargin)
% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface

% Last Modified by GUIDE v2.5 21-Mar-2023 13:07:51

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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


% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

% Choose default command line output for Interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
% Désactivez tous les panneaux sauf le premier
%set(handles.uipanel8, 'Visible', 'off');
%set(handles.uipanel3, 'Visible', 'off');
%set(handles.uipanel4, 'Visible', 'off');


% Affichez le premier panneau
set(handles.uipanel1, 'Visible', 'on');


% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ChoisirImage.
function ChoisirImage_Callback(hObject, eventdata, handles)
% hObject    handle to ChoisirImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Fonction callback pour le bouton "Choisir une image"
% Ouvre une boîte de dialogue de sélection de fichier
% Ouvre une boîte de dialogue pour choisir une image

[filename, pathname] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.gif';'*.*'}, 'Choisir une image');
if ~isequal(filename, 0)
    % Charge l'image choisie et l'affiche dans l'objet Axes "axes1"
    image = imread(fullfile(pathname, filename));
    hAxes = findobj('Tag', 'axes1');
    %image = getimage(handles.axes1);
    imshow(image, 'Parent', hAxes);
    %imshow(image, 'Parent', handles.axes1);
end



% --- Executes on button press in SizeIMG.
function SizeIMG_Callback(hObject, eventdata, handles)
% hObject    handle to SizeIMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get the image data from the axes
axes(handles.axes1);
imdata = getimage;

% Get the size of the image
imsize = size(imdata);
% Set the static text to display the size of the image
size_str = sprintf('SIZE : %d x %d', imsize(2), imsize(1));
set(handles.AffichageSize, 'String', size_str);


% --- Executes on button press in RotationIMG.
function RotationIMG_Callback(hObject, eventdata, handles)
% hObject    handle to RotationIMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imdata = getimage;
imsize = size(imdata);

% Prompt user for the degree of rotation
prompt = 'Angle de Rotation : ';
deg = str2double(inputdlg(prompt));

% Rotate the image
rotated = imrotate(imdata, deg);

% Display the rotated image
axes(handles.axes2);
imshow(rotated);

title(sprintf('Rotation d''angle %d', deg));

% Update the static text to show the new image size
text_str = sprintf('Size: %d x %d', size(rotated, 1), size(rotated, 2));
set(handles.size_txt, 'String', text_str);


% --- Executes on button press in InversionIMG.
function InversionIMG_Callback(hObject, eventdata, handles)
% hObject    handle to InversionIMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get the current axes
current_axes = handles.axes1;
% Get the current image
current_image = getimage(current_axes);
% Reverse the color of the image
reversed_image = imcomplement(current_image);
% Display the reversed image in the second axes
axes(handles.axes2);
imshow(reversed_image);
title(sprintf('Image Inversée'));

%problemeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% --- Executes on button press in BlockIMG.
function BlockIMG_Callback(hObject, eventdata, handles)
% hObject    handle to BlockIMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%"start_row" et "start_col" sont les coordonnées du coin supérieur gauche du bloc,
% Get the current axes
current_axes = handles.axes1;
% Get the current image
current_image = getimage(current_axes);
start_row = 50;
start_col = 60;
block_rows = 10; %"block_rows" est le nombre de lignes dans le bloc 
block_cols = 5; %"block_cols" est le nombre de colonnes dans le bloc
%"block" une sous-matrice de "img" contenant les lignes et les colonnes spécifiées
block = current_image(start_row:(start_row+block_rows-1), start_col:(start_col+block_cols-1));    
axes(handles.axes2);
imshow(block);
title(sprintf('Block de l''image'));




% --- Executes on button press in HistogrammeIMG.
function HistogrammeIMG_Callback(hObject, eventdata, handles)
% hObject    handle to HistogrammeIMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imdata = getimage;

% Calculate the histogram of the image
num_bins = 256;
[counts,~] = imhist(imdata, num_bins);

% Plot the histogram in axes2
axes(handles.axes3);
bar(counts);
ylabel('PIXELS');
xlabel('INTENSITY');
title('Histogramme');


% --- Executes on button press in LigneIMG.
function LigneIMG_Callback(hObject, eventdata, handles)
% hObject    handle to LigneIMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
row_num_str = inputdlg('Enter the row number:');
row_num = str2double(row_num_str);

% Get the image data from the axes
axes(handles.axes1);
imdata = getimage;

% Get the size of the image
imsize = size(imdata);

% Calculate the profile for the specified row
if row_num > 0 && row_num <= imsize(1)
    profile_data = imdata(row_num,:);
    axes(handles.axes3);
    plot(profile_data);
    xlabel('Nombre de ligne');
    ylabel('Niveau de gris');
    title(sprintf('Profil de la ligne %d ', row_num));
else
    errordlg(sprintf('Invalid row number. Enter a value between 1 and %d.', imsize(1)), 'Error');
end



% --- Executes on button press in ColonneIMG.
function ColonneIMG_Callback(hObject, eventdata, handles)
% hObject    handle to ColonneIMG (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);
imdata = getimage;

% Get the size of the image
imsize = size(imdata);

% Get the profile column number from the user
prompt = 'Enter the column number for the profile:';
col_num_str = inputdlg(prompt);
col_num = str2double(col_num_str);

% Calculate the column profile
profile = mean(imdata(:, col_num), 2);

% Plot the profile in the second axes
axes(handles.axes3);
plot(profile);

% Set the title and axis labels
xlabel('Nombre de colonne');
ylabel('Niveau de gris');
title(sprintf('Profil de la colonne %d', col_num));









% --- Executes on button press in IMGBinaire.
function IMGBinaire_Callback(hObject, eventdata, handles)
% hObject    handle to IMGBinaire (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
gray_val = str2double(inputdlg('Donner le niveau de gris :', 'Gray Value'));

% Get the image data from the axes
axes(handles.axes1);
imdata = getimage;

% Convert the image to grayscale if it's not already grayscale
if size(imdata,3) > 1
    imdata = rgb2gray(imdata);
end

% Replace pixels with gray_val with 0, and others with 255
imdata(imdata == gray_val) = 255;
imdata(imdata ~= 255) = 0;

% Display the modified image in the second axes
axes(handles.axes2);
imshow(imdata);
title(sprintf('Image Binaire'));


% --- Executes on button press in Speckleimg.
function Speckleimg_Callback(hObject, eventdata, handles)
% hObject    handle to Speckleimg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Get the image
axes(handles.axes1);
imdata = getimage;

% Get the noise variance from user input
variance = str2double(inputdlg('Enter the noise variance:'));

% Add speckle noise to the image
noisy_im = imnoise(imdata, 'speckle', variance);

% Display the noisy image in axes4
axes(handles.axes4);
imshow(noisy_im);
title(sprintf('Bruit Speckle'));



% --- Executes on button press in SaltandPepper.
function SaltandPepper_Callback(hObject, eventdata, handles)
% hObject    handle to SaltandPepper (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
imdata = getimage;

% Get the noise variance from user input
variance = str2double(inputdlg('Enter the noise variance:'));

% Add speckle noise to the image
variance = rand(size(imdata)) > 0.9;
img_noisy = imdata;
img_noisy(variance) = 255;
img_noisy(~variance) = 0;

% Display the noisy image in axes4
axes(handles.axes4);
imshow(img_noisy);
title(sprintf('Bruit Salt and Paper'));


% --- Executes on button press in PsnrSpeckle.
function PsnrSpeckle_Callback(hObject, eventdata, handles)
% hObject    handle to PsnrSpeckle (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
im1 = getimage;
axes(handles.axes4);
im2 = getimage;

% Calculate PSNR
MSE = mean(mean((im1 - im2).^2));
MAX = 255;
PSNR = 20*log10(MAX/sqrt(MSE));

% Display PSNR in static text
set(handles.text4, 'String', sprintf('PSNR = %.2f db', PSNR));


% --- Executes on button press in PsnrSandP.
function PsnrSandP_Callback(hObject, eventdata, handles)
% hObject    handle to PsnrSandP (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
im1 = getimage;
axes(handles.axes4);
im2 = getimage;

% Calculate PSNR
MSE = mean(mean((im1 - im2).^2));
MAX = 255;
PSNR = 20*log10(MAX/sqrt(MSE));

% Display PSNR in static text
set(handles.text5, 'String', sprintf('PSNR = %.2f db', PSNR));





% --- Executes on button press in FiltreMoyen.
function FiltreMoyen_Callback(hObject, eventdata, handles)
% hObject    handle to FiltreMoyen (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter filter size in X direction:', 'Enter filter size in Y direction:'};
dlgtitle = 'Median Filter Size';
dims = [1 50];
definput = {'3', '3'};
answer = inputdlg(prompt, dlgtitle, dims, definput);
filterSizeX = str2double(answer{1});
filterSizeY = str2double(answer{2});

% Apply the median filter with the user-defined filter size
axes(handles.axes4);
imdata = getimage;
imdata = im2double(imdata);
filtered = medfilt2(imdata, [filterSizeX filterSizeY]);
imshow(filtered, []);




% --- Executes on button press in Filtre_Median.
function Filtre_Median_Callback(hObject, eventdata, handles)
% hObject    handle to Filtre_Median (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Enter filter size in X direction:', 'Enter filter size in Y direction:'};
dlgtitle = 'Median Filter Size';
dims = [1 50];
definput = {'3', '3'};
answer = inputdlg(prompt, dlgtitle, dims, definput);
filterSizeX = str2double(answer{1});
filterSizeY = str2double(answer{2});

% Appliquer le filtre médian avec la taille de filtre définie par l'utilisateur
axes(handles.axes4);
imdata = getimage;
imdata = im2double(imdata);
filtered = medfilt2(imdata, [filterSizeX filterSizeY]);
imshow(filtered, []);




% --- Executes on button press in SUIVANT_Button.
function SUIVANT_Button_Callback(hObject, eventdata, handles)
% hObject    handle to SUIVANT_Button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.uipanel8, 'Visible', 'off');


% Affichez le premier panneau en plein écran
set(handles.uipanel1, 'on');
