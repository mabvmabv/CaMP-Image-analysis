clc
close all;
clear all;
fclose('all');

global roi maxi maim fcount nfp frperc

maim=65535;
maxi=2500;

f=fopen('out','a');
newfile();

while fcount<nfp
 threshold();
 yn2='No';
 yn='No';
 fpv=5;
 while strcmp(yn,'No') &&  strcmp(yn2,'No')
  prompt={'Frames to check from', 'Number of frames',...
    'Start automated analysis?', 'Change parameters and start over?'};
        title=strcat(num2str(fcount),'+',num2str(fpv));
        def={num2str(fcount+1), '5', 'No', 'No'};
        answer=inputdlg(prompt,title, 1, def);
        stfrt = str2double(answer{1});
        frperct = str2double(answer{2});
        yn=answer{3};
        yn2=answer{4};
  if strcmp(yn,'No') && strcmp(yn2,'No')
   for kk = fcount+1:fcount+fpv
    regions(kk)
   end
  end
 end 

 if ~strcmp(yn,'No') 
  flast=fcount+frperc;
  ffirst=fcount+1;
  for kk = ffirst:flast
    fcount=fcount+1; 
    regionsauto(kk);
    ss=length(roi);
    if ss>0 
      fprintf(f,'frame %d %d\n',fcount, ss);
      for s=1:ss
        fprintf(f,'%3d %4d %7.1f %7.1f %7.1f %7.1f\n',s, roi(s).Area,...
          roi(s).WeightedCentroid, roi(s).MaxIntensity,...
          roi(s).MeanIntensity) ;
      end  
    end
  end
  fcount
 end
end
fclose('all');
