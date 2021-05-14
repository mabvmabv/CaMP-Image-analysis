function[] = readoutall

global all ra 
colall=8;

f=fopen('outall','r');
ra=fscanf(f,'%d',1)
all=zeros(ra,colall);
for i=1:ra
 all(i,:)=fscanf(f,'%d',colall);
end
fclose(f);
end

