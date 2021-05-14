clc
close all;
clear all;
fclose('all');
%%
global all nz pz fps fap nap ev sp del mf sph hipazs azw wa

readoutall();
readroi();
mapazcm(nz,pz,0);

a=inputdlg('frames per second - mas o menos');
fps=str2num(a{1})

delbad1();
ap();

if fps~=0
    evsp1();
else
    spon();
end
wrip();
stats3();
heatmap();
diflat();
latclus1();
burst();
waves();




