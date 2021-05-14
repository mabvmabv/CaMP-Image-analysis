function [] = stats3()
global pz fps nap mf nz ns hipaze hipazs pcute pcuts bot maxspf 
pcute=0.2;

f=fopen('stat','w');
fprintf(f,'Number of active zones: %d \n', nz);
if (nap~=0)
 fprintf(f,'evoked\n');
 maxe=max(pz(:,4))+1;
 x=1:maxe;
 x=x-1;
 ce=hist(pz(:,4),x);
 [poi,chi,lambdae]=pfit2(ce,maxe);
 maxpf=maxe;
 chil=chi;
 while chil>7. && maxpf>4
    maxpf=maxpf-1;
    cel=ce(1:maxpf);
    [poil,chil,lambdae]=pfit2(cel,maxpf);
 end    

 if maxpf==maxe
     poil=poi;
 else
     poil((maxpf+2):maxe)=0;
 end    
 figure
 plot(x,ce,x,poi(1:maxe),x, poil(1:maxe));

 
fprintf(f,'\n expected average low p =%f\n',lambdae/nap);
fprintf(f,'expected number of low p zones remaining silent by chance %d\n',poil(1));
fprintf(f,'\n\n high p zones\n');

pep=double(x)./double(nap);
xxx=find(pep>=pcute);
[sx]=size(xxx,2);
iz1=0;
for j=1:sx
    ppz=pz(:,4);
    yyy=find(ppz==xxx(1,j)-1);
    [sy]=size(yyy,1);
    iz2=iz1+sy;
    iz1=iz1+1;
    zzz(1,iz1:iz2)=yyy(:,1);
    iz1=iz2;
end
[np]=size(zzz,2);
mapazcm(nz,pz,np,zzz);

hipaze=zeros(1,np);
for i=1:np
    in=zzz(i);
    hipaze(1,i)=pz(in,1);
end    
fprintf(f,'%d ', hipaze);
 hap=sum(pz(hipaze,4))/np/nap;
 fprintf(f,'\n average p in high p zones %f \n per cent of high p zones %f \n',hap,100*double(np)/double(nz));
 
 for i=1:maxe
   fprintf(f,'%6d %6f %6d %6f %6f\n', x(i), pep(i),ce(i), poi(i), poil(i));
 end 
 fprintf(f,'chi2=%6f %6f\n', chi,chil); 
 
if(np>2)
 xhpe=zeros(np,2);
 for i=1:np
    in=zzz(i);
    xhpe(i,:)=pz(in,2:3); 
 end
 xall=pz(:,2:3);
 [clo,cle,stdcle]=clust(xhpe,xall);
 fprintf(f,'\n cluster observed %f expected - mean and std %f %f\n',clo,cle,stdcle);
 
 
end
end 
 
fprintf(f,'\nspontaneous\n');
maxs=max(pz(:,5))+1;
x=1:maxs;
x=x-1;
cs=hist(pz(:,5),x);

[pois,chis,lambdas]=pfit2(cs,maxs);

 maxspf=maxs;
 chils=chis;
 while chils>7. && maxspf>4
    maxspf=maxspf-1;
    csl=cs(1:maxspf);
    [poisl,chils,lambdas]=pfit2(csl,maxspf);
 end    
 
 if maxspf==maxs
     poisl=pois;
 else
     poisl(maxspf+1:maxs)=0;
 end    
 
figure
plot(x,cs,x,pois(1:maxs),x, poisl(1:maxs));
 
ns=double(mf)/double(fps);
psp=double(x)./ns;

fprintf(f,'\nexpected average low p =%f\n  lambda = %f\n',lambdas/ns, lambdas);
fprintf(f,'expected number of low p zones remaining silent by chance %d\n',poisl(1));

pcuts=double(maxspf)/ns ;
fprintf(f,'cut=%f\n', pcuts);

for i=1:maxs
     fprintf(f,'%6d %6f %6d %6f %6f\n', x(i), psp(i) ,cs(i), pois(i), poisl(i));
 end  
fprintf(f,'\nchi2=%f  %f lambda=%f\n',chis, chils, lambdas);

xxx=find(psp>=pcuts);
[s,sx]=size(xxx);
if(sx~=0)
 ppz=pz(:,5);    
 iz1=0;
 for j=1:sx
    yyy=find(ppz==xxx(1,j)-1);
    [sy,s]=size(yyy);
    iz2=iz1+sy;
    iz1=iz1+1;
    zzs(1,iz1:iz2)=yyy(:,1);
    iz1=iz2;
 end
 [np]=size(zzs,2);
 hipazs=zeros(1,np);
 for i=1:np
    in=zzs(i);
    hipazs(1,i)=pz(in,1);
 end
 hipazs=sort(hipazs);
 fprintf(f,'\n');1
 fprintf(f,'%d ', hipazs);
 hap=sum(pz(hipazs,5))/ns/np;
 php=100*double(np)/double(nz);
 fprintf(f,'\n average p in high p zones %f per second\n per cent high p zones %f %f\n', hap, php, np);
 fprintf(f,'Number of events in high p zones %d\n', sum(pz(hipazs.',5)));
 fprintf(f,'Overall number of events  %d\n\n', sum(pz(:,5)));
 if(np>2)
  xhpe=zeros(np,2);
  for i=1:np
    in=zzs(i);
    xhpe(i,:)=pz(in,2:3); 
  end
  xall=pz(:,2:3);
  [clo,cle,stdcle]=clust(xhpe,xall);
  fprintf(f,'\n cluster observed %f expected - mean and std %f %f\n\n',clo,cle,stdcle);
 end
else
    hipazs=[];
end
bot=intersect(hipazs,hipaze);
fprintf(f,'high p mixed zones ');
fprintf(f,'%d ', bot);
fclose(f);
end

