function[] = readall

global all nr colall 

f=fopen('out','r');

iss=zeros(1,colall);

while ~feof(f)
 line=fgets(f);
 an=strcmp(line(1:5),'frame');
 if an~=1
     line
 end   
 [s]=sscanf(line,'%*s %d %d');
 nf=s(1);
 nr(nf)=s(2);

 for i=1:nr(nf)
   line=fgets(f);
   [ss]=sscanf(line,'%d %d %f %f %f %f');
   iss(1,1:6)=int16(ss);
   iss(1,7)=nf;
   all=cat(1,all,iss);
 end
 
end
all(1,:)=[];
fclose(f);
end

