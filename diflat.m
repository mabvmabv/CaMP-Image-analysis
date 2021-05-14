function [] = diflat()
global fps nap ev sp ns maxspf

if nap~=0
msizdi=nap*100;
cou=1;
dif=zeros(1,msizdi);
se=size(ev,1)
i=1;
while i<=se
 jz=ev(i,1);
 xxx=find(ev(:,1)==jz);   
 sx=size(xxx,1);
 if sx>1
  for j=i:(i+sx-2);
     d1=ev(j+1,2);
     d2=ev(j,2);
     dif(cou)=d1-d2;
     cou=cou+1;
  end
 end 
 i=i+sx;
end

cou=cou-1
dif(1:cou)
ds=dif(1,1:cou).';
save('dif','ds','-ascii')
maxd=max(dif,[],2);
nbins=maxd/fps
figure
hist(dif(1,1:cou),nbins)
end

msizdi=round(ns*100);
cou=1;
couhp=1;
dif=zeros(1,msizdi);
difhp=zeros(1,msizdi);
se=size(sp,1)
i=1;
while i<=se
 jz=sp(i,1);
 xxx=find(sp(:,1)==jz);   
 sx=size(xxx,1);
 if sx>1
  if sx<maxspf
   for j=i:(i+sx-2);
     d1=sp(j+1,2);
     d2=sp(j,2);
     dif(cou)=d1-d2;
     cou=cou+1;
   end
   else
     for j=i:(i+sx-2);
     d1=sp(j+1,2);
     d2=sp(j,2);
     difhp(couhp)=d1-d2;
     couhp=couhp+1;
     end
  end    
 end 
  i=i+sx;
end

cou=cou-1;
couhp=couhp-1;
ds=dif(1,1:cou).';
save('difs','ds','-ascii')
dshp=difhp(1,1:couhp).';
save('difshp','dshp','-ascii')

maxd=max(dif,[],2)
nbins=maxd/ns*10
figure
hist(dif(1,1:cou),nbins)

maxd=max(difhp,[],2)
nbins=maxd/ns*10
if nbins > 0
  figure
  hist(difhp(1,1:couhp),nbins)
end  

end



