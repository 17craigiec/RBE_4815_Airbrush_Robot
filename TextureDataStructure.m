%STARTUP CLEAR
clear
clc
close all

addpath('Textures');
image = imread('Capture.png');
%imshow(image);

%POINTS PER INCH
PPI = 1;
%RADIUS IN INCHES
r = 10;

index = 1;
size = getDataSize(r, PPI);
%dataStruct = [ X,Y,Z , R,G,B ]
dataStruct = zeros(size, 6);

numPtsVert = floor(pi*r*PPI);

for n = 1:numPtsVert
    %range: 90 to -90
    %will produce evenly spaced vertical points along a latitude line
    thVert = 90 - 180*n/numPtsVert;
    
    %will produce the apropriate number of horizontal pts for a given
    %incllination
    numPtsHorz = floor(2*cosd(thVert)*r*pi*PPI);
    
    for i = 1:numPtsHorz
        %range: 0 to 360
        %will produce evenly spaced horizontal points along a longitue line
        thHorz = floor(360*i/numPtsHorz);

        dataStruct = updateStructPos(r,thHorz,thVert,dataStruct,index);
        dataStruct = updateStructCol(image,numPtsVert,n,numPtsHorz,i,dataStruct,index);
        index = index + 1;
        
    end
    
end

printPath(dataStruct);
%printColor(dataStruct);


%HELPER FUNCTIONS
%====================================================================

function printPath(dataStruct)
    plot3(dataStruct(:,1),dataStruct(:,2),dataStruct(:,3), '-r');
    axis equal; grid on;
end

function printColor(dataStruct)

    [h,~] = size(dataStruct);
    
    for i = 1:h
        x = [0; dataStruct(i,1)];
        y = [0; dataStruct(i,2)];
        z = [0; dataStruct(i,3)];
        r = dataStruct(i,4)/255;
        g = dataStruct(i,5)/255;
        b = dataStruct(i,6)/255;
        plot3(x, y, z, '*', 'Color', [r g b] );
        hold on;
    end
    axis equal; grid on;
end

function dataStruct = updateStructPos(r,thHorz,thVert,dataStruct,index)
    
    rs = r*cosd(thVert);

    x = rs*cosd(thHorz);
    y = rs*sind(thHorz);
    z = r*sind(thVert);

    dataStruct(index, 1) = x;
    dataStruct(index, 2) = y;
    dataStruct(index, 3) = z;

end

function dataStruct = updateStructCol(image,numPtsVert,n,numPtsHorz,i,dataStruct,index)
    
    [h,w,~] = size(image);
    
    hightPix = floor(h*n/numPtsVert);
    widthPix = floor(w*i/numPtsHorz);
    
    dataStruct(index, 4) = image(hightPix, widthPix, 1);
    dataStruct(index, 5) = image(hightPix, widthPix, 2);
    dataStruct(index, 6) = image(hightPix, widthPix, 3);

end

function size = getDataSize(r, PPI)

    size = 0;
    numPtsVert = floor(pi*r*PPI);
    for n = 1:numPtsVert
        thVert = 90 - 180*n/numPtsVert;
        numPtsHorz = floor(2*cosd(thVert)*r*pi*PPI);
        
        size = size + numPtsHorz;
    end

end