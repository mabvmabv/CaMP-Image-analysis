function [] = cleansmall

global all 
xxx=find(all(:,8)==0);
all(xxx,:)=[];




