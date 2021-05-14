function [] = classi2
global all p cut 

clc;
pt=p.' ;
d=pdist(pt);
[ra,col]=size(all);
allnew=all;
sd=squareform(d);

[i1,i2]=find(sd<cut);
[r,r1]=size(i1);
mat=zeros(r,2,'uint16');
mat(:,1)=i1;
mat(:,2)=i2;

[ran,col]=size(allnew);
while ran>1
  [inm,ninm]=max(allnew(:,6));
  rc=allnew(ninm,8);
  xxx=find(mat(:,2)==rc);
  yyy=mat(xxx,1);
  [s,s1]=size(yyy);
  for iii=1:s
        zzz=find(all(:,8)==yyy(iii,s1));
        all(zzz,8)=rc;
        rc
        allnew( (allnew(:,8)==yyy(iii,s1)) , :)=[] ;
  end      
 [ran,col]=size(allnew);
 end  