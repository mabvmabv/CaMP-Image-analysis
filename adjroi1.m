function [] = adjroi1
global p roi all

p=zeros(2,roi,'uint16');
for j=1:roi
    xxx=find(all(:,8)==j);
    [s,s1]=size(xxx);
    p2(1:s,1:2)=all(xxx,3:4);
    p2m=uint16(mean(p2(1:s,:),1));
    p(:,j)=p2m.';
end




