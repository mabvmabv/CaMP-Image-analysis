function [] = delbad1
global udz nz pz fps all

delz=zeros(1,50,'uint16');
kdel=1;

mlf=fps-1
for i=1:nz
    xxx=find(all(:,8)==i);
    [s,s1]=size(xxx);
    jj=1;
    while jj<s
      k=1; 
      while (jj<s) && (xxx(jj,1)+1==xxx(jj+1,1)) 
          k=k+1;
          jj=jj+1;
      end
      if k>mlf
          delz(1,kdel)=i;
          xxx(jj,1)
          kdel=kdel+1;
      else if k==1
               jj=jj+1;
           end 
      end     
    end
end
udz=unique(delz);
udz(:,1)=[];
kdel=size(udz,2);
mapazcm(nz,pz,kdel,udz);

for i=1:kdel
  k=kdel-i+1;
  kz=udz(1,k);
  str=['exclude AZ  ',num2str(kz),' ?'];
  answ = inputdlg(str,'delete',1,{'N'});
  if answ{1}=='N' 
      udz(:,k)=[];
  end
end    
udz
[s,sz]=size(udz);
mapazcm(nz,pz,sz,udz);
nz=nz-sz
for i=1:sz
     xxx=find(all(:,8)==udz(i));
     [sx,s]=size(xxx);
     for j=1:sx
        k=sx+1-j;
        jjj=xxx(k);
        all(jjj,:)=[];
     end    
end
for i=1:sz
    k=sz+1-i;
    jjj=udz(k);
    pz(jjj,:)=[]; 
end

end

