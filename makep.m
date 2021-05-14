function [] = makep( )
global all pp npp

[npp,col]=size(all)
ppp=zeros(2,npp,'uint16');
ppp(1:npp, 1:2)=all(1:npp,3:4);
pp=ppp.'  ;
end


