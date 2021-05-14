function [clo,cle,stdcle] = clust( x,xxr )
[nro]=size(x,1);
[nr]=size(xxr,1);
p=pdist(x);
m1=mean(p);
pp=pdist(xxr);
m2=mean(pp);
clo=m1/m2;

rep=100;
r=rand(nro,rep);
nran=int16(r*(nr-1))+1;
xroran=zeros(nro,2);

for j=1:rep
for i=1:nro
    c=nran(i,j);
    xroran(i,:)=xxr(c,:);
end
ppp=pdist(xroran);
m33(j)=mean(ppp);
end
m3=mean(m33);
sem3=std(m33);
cle=m3/m2;
stdcle=sem3/m2;
end

