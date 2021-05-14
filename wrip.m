function [] = wrip()
global nz pz fps ev sp

f=fopen('azes','w')
for i=1:nz
    j=pz(i,1);
    if fps~=0
      [s,s1]=size(find(ev(:,1)==j));
      pz(i,4)=s;
    end
    [s,s1]=size(find(sp(:,1)==j));
    pz(i,5)=s;
    fprintf(f,'%6d',pz(i,:)) ; 
    fprintf(f,'\n');
end
fclose(f);


