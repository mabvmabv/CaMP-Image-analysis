function[] = readroi

global nz pz
f=fopen('az');
nz=fscanf(f,'%d',1)
pz=zeros(nz,5);
for i=1:nz
 ii=fscanf(f,'%d',3);   
 pz(i,1:3)=ii;
end
fclose(f);
end

