function [] = ap()
global all fps fap nap mf

zah=5;
mf=max(all(:,2))
a=inputdlg('stimulation frequency (Hz, 0 for spontaneous)');
f=str2num(a{1})

if(f~=0)
 fpa=int16(fps/f)
else
   nap=0; 
   return
end 
fpam=fpa+zah;

a=inputdlg('Load frames?','AP frames',1,{'N'});
if a{1}~='N'
 fap=load('frames.txt','-ascii');
 [n1,nap]=size(fap)
 return;
end

nap=int16(mf/fpa+1)-1
fap=zeros(1,nap);
%%
fmc=0;
cf=1;
ia=1;
fpp=0;
for i=1:nap
  cfm=fmc+fpam;
  if cfm>mf
      cfm=mf;
  end
  arfaz=zeros(nap,fpam);
  iarf=all(ia,2)-fpp;
  while all(ia,2)<cfm 
    iarf=all(ia,2)-fpp;   
    arfaz(i,iarf)=arfaz(i,iarf)+1;
    ia=ia+1;
  end
  [c,in]=max(arfaz(i,:));
  fmc=in+fpp; 
  fap(1,i)=fmc;
  fmc=fmc+zah ;
  if fmc >= (mf-fpa)
      break;
  end 
  while all(ia,2)>fmc 
      ia=ia-1;
  end
  while all(ia,2)<fmc 
      ia=ia+1;
  end
  cf=all(ia,2);
  fpp=cf-1;
end
ind=find(fap,1,'last');
if ind<nap && mf-fap(ind)<fpa
    fap(nap)=[]; 
    nap=nap-1;
end   
fap
save('frames.txt','fap','-ASCII');
a=inputdlg('Fix frames?','AP frames',1,{'N'});
if a{1}~='N'
fap=load('frames.txt','-ascii')    
end

