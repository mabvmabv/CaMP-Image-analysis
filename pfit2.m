function [poirot, chi,la] = pfit2( mro, mreal )

poiro=zeros(1,mreal,'double');
mroreal=mro;
mroreal(1)=mroreal(2);
ii=1:mreal;
ir=ii-1;
sexp=sum(mroreal)-mroreal(1);
lael=zeros(2,mreal);

for j=1:10
 tot=sum(mroreal);
 lael=ir.*mroreal;
 la=sum(lael)/tot;
 mroreal(1)=int16(tot*exp(-la));
end
poiro=poisspdf(ir,la);
sp=sum(poiro(:,2:mreal))
poirot=poiro*sexp/sp;
poirot(1)=mroreal(1);
% tot
% sum(mroreal)
% sum(poirot)
% mroreal(1)
% poirot(1)

chiel=zeros(1,mreal);
for i=2:mreal
  if poirot(1,i)>0 
    chiel(1,i)=(mroreal(i)-poirot(1,i)).*(mroreal(i)-poirot(1,i))/poirot(1,i);
  end
end  
chi=sum(chiel);

%mroreal(1)=mro(1);
end

