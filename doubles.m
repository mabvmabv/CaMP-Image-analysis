function doubles()
global roi all

for i=1:roi
  xxx=find(all(:,8)==i);
  fre=all(xxx,7);
  uf=unique(fre);
  fc=histc(fre,uf);
  xf=find(fc>1)
  nrep=length(xf)
  for kk=1:nrep
    ifr=xf(kk);  
    fr=uf(ifr);
    indf=find(all(:,7)==fr & all(:,8)==i);   
    sd=fc(ifr)-1;
    all(indf(1:sd),:)=[];
  end    
 end




