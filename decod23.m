clc
close all;
clear all;
fclose('all');

global all colall cut roi pp npp p 

cut=4.;
colall=9;
all=zeros(1,colall);
readall;
all=int16(all);

readim;
makep;
imaroi(npp,pp); 
%%
neighbors;
cleansmall;
sortall();
adjroi1;
imaroi(roi,p);
%%
classi2;
sortall();
doubles();
adjroi1;
imaroi(roi,p);

region;
sortall();
adjroi1;
imaroi(roi,p);

f1=fopen('az','w');
fprintf(f1, '%d\n', roi);
for r=1:roi
  fprintf(f1, '%8d %8d %8d\n', r, p(:,r));
end

allf=all;
allf(:,9)=[];
allf(:,1)=all(:,7);
allf(:,7)=[];

[ra,col]=size(allf);

 f1=fopen('outall', 'w');
 fprintf(f1, '%5d\n', ra);
 for i=1:ra
     fprintf(f1, '%5d %5d %5d %8d %8d %5d %5d %5d\n', i, allf(i,:));
 end
 fclose('all');
 
  
 
 



