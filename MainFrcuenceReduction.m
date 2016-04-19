close all
clear 

%% Select Image
Filter={'*.jpg;*.jpeg;*.png;*.tif'};
[FileName, FilePath]=uigetfile(Filter);
pause(0.01);
if FileName==0
    return;
end
FullFileName=[FilePath FileName];
%% Number of Desired Colors
ANSWER = inputdlg('Number of desired colors:','Color Reduction',1,{'16'});
pause(0.01);
k = str2double(ANSWER{1});
%% Load Image Data
Imagen = imread(strcat(FullFileName));
%Imagen = rgb2lab(Imagen);
%% Reduction image
[h, w, p] = size(Imagen);
patterns = imageData3xn(Imagen);
[ux, ia, ic] = groupNColors(patterns);
[ImgPat, unicos, clases] = reconstruir(patterns, ux, k);

unicos = double(unicos);
Centroides = ColorReduction(clases, unicos, 8, k);
[uxn, ~, ~] = groupNColors(Centroides);
% unicos = double(unicos);
% patterns = double(patterns);

%  [Clases, Centroides, SumDistancias, Distancias] = kmeans(patterns,...
%     k,'MaxIter',1000,'Distance', 'sqeuclidean', 'Start', unicos, 'EmptyAction','singleton');
MatrizCentroides = AsignaCentroides(clases, Centroides);
img = patToImage(MatrizCentroides, w, h);
% img = double(img);
% img = lab2rgb(img);
%img = uint8(img);
%% Show Results
figure;
subplot(1,2,1);
imshow(Imagen);
title('Original');

subplot(1,2,2);
imshow(img); 
title(['Color Reduced Image (R = ' num2str(k) ') Reduction of colors to ' num2str(length(uxn))]);
