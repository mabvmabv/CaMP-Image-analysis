function [ ] = readim

global all w h maxi a
maxi=5000;
[fl,pt]=uigetfile('*.tif'); 
flpt=strcat(pt,fl)
a=imread(flpt,1);
[w,h] = size(a);
end

