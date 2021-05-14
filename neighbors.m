function [] = neighbors

global all nr roi cut

[maxall,cc]=size(all);
c=1;
roi=1;

while c<maxall   
 nf=all(c,7); 
 c1=c+nr(nf)-1;
 x=zeros(nr(nf),2,'int16');
 x(1:nr(nf),1:2)=all(c:c1,3:4);
 c2=c1+1;
 if c2>maxall 
     break;
 end
 nfnew=all(c2,7);
 if nfnew==nf+1
  c3=c1+nr(nfnew);
  y=zeros(nr(nfnew),2,'int16');
  y(1:nr(nfnew),1:2)=all(c2:c3,3:4);
  d=pdist2(x,y);
   
  for i=1:nr(nf)
     for j=1:nr(nfnew)
         if d(i,j)<cut
             ii=c+i-1;
             jj=c1+j;
             if all(ii,8)~=0 
                 all(jj,8)=all(ii,8);
             else
                 all(ii,8)=roi;
                 all(jj,8)=roi;
                 roi=roi+1;
             end
         end
     end
   end
 end
 c=c2;
end
roi=roi-1

