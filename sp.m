function [] = evsp( )
global all nz fap ev sp 


[ra,col]=size(all);
sp=zeros(ra,3);

for i=1:nz
  alev=find(all(:,8)==i);
  [sa,s]=size(alev);
  fr=all(alev(1:sa),2);
  j=1;
  while j<sa-1
      j1=j;
      while fr(j,1)+1 == fr(j+1,1)
        j=j+1;
        if j==sa
            break;
        end    
      end
      j2=j;
      df=max(all(alev(j1:j2),6));
          sp(nev,1)=i;
          sp(nev,2)=fr(j1,1);
          sp(nev,3)=df;
      j=j+1;
      nev=nev+1;
  end
end
[ras,cos]=size(sp);
for i=1:ras
    j=ras-i+1;
    if sp(j,1)==0
       sp(j,:)=[];
    end
end   
  [ras,cos]=size(sp);
  f=fopen('events','w');
  fprintf(f,'spontaenous %6d\n',ras);
  for i=1:ras
      fprintf(f,'%6d %6d %6d\n',sp(i,:));
  end
  fclose(f);
end

