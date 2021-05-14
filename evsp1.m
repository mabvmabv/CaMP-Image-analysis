function [] = evsp1( )
global all nz fap ev sp 


[ra,col]=size(all);
ev=zeros(ra,3);
sp=zeros(ra,3);

fapm1=fap-1;
fap1=fap+1;
nev=1;

for i=1:ra  
  alev=find(all(:,8)==i);
  [sa,s]=size(alev);
  fr=all(alev(1:sa),2);
  j=1;
  while j<=sa
      j1=j;
      if j<sa
       while fr(j,1)+1 == fr(j+1,1)
        j=j+1;
        if j==sa
            break;
        end    
       end
      end 
      j2=j;
      df=max(all(alev(j1:j2),6));
      ksw=0;
      [s1,s2]=size(find(fap==fr(j1,1)));
      if s2>0 
          ksw=1;
      else     
          [s1,s2]=size(find(fap1==fr(j1,1)));
          if s2>0
              ksw=1;
          else     
            [s1,s2]=size(find(fapm1==fr(j1,1)));
           if s2>0
              ksw=1;
           end
          end
      end   
      if ksw>0
          ev(nev,1)=i;
          ev(nev,2)=fr(j1,1);
          ev(nev,3)=df;
      else    
          sp(nev,1)=i;
          sp(nev,2)=fr(j1,1);
          sp(nev,3)=df;
      end
      j=j+1;
      nev=nev+1;
      
  end
end
[rae,coe]=size(ev);
[ras,cos]=size(sp);
for i=1:rae
    j=rae-i+1;
    if ev(j,1)==0
        ev(j,:)=[];
    end
end   
for i=1:ras
    j=ras-i+1;
    if sp(j,1)==0
       sp(j,:)=[];
    end
end   
  [rae,coe]=size(ev);
  [ras,cos]=size(sp);
  f=fopen('events','w');
  fprintf(f,'evoked %6d\n',rae);
  for i=1:rae
      fprintf(f,'%6d %6d %6d\n',ev(i,:));
  end    
  fprintf(f,'spontaenous %6d\n',ras);
  ras
  for i=1:ras
      fprintf(f,'%6d %6d %6d\n',sp(i,:));
  end
  fclose(f);
end

