%STARTUP CLEAR
clear
clc
close all

addpath('Textures');
image = imread('Mercator_projection_SW.jpg');
imshow(image);

[X,Y,Z] = ellipsoid(0,0,0,1,1,1);

figure()
s = surf(X,Y,-Z,'FaceAlpha',0.9);
h = findobj('Type','Surface');
set(h,'CData',image,'FaceColor','texturemap')
axis equal;

def = 10;
horzScale = 3;

dataPts = zeros(6,def^2*horzScale);
% 
% for n = 1:def*horzScale
%     
%     thHorz = floor(360*n/(def*horzScale));
%     %will produce 10 vertical points along a latitude line
%     
%     for i = 1:def
%         
%         %range: 90 to -90
%         thVert = 90 - floor(180*i/def);
%         
%         
%         
%     end
%     
% end
% 
% function [x,y,z] = getUnitXYZ(thHorz,thVert)
% 
% end
