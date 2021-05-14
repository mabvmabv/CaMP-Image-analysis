function [ ] = sortall()

global all roi

y=unique(all(:,8));
[ra,col]=size(all);
[roi,r1]=size(y)
rr=zeros(ra,1,'int16');
for i=1:roi
  xxx=find(all(:,8)==y(i,1));
  rr(xxx,1)=i;
end
all(:,8)=rr(:,1);
end







