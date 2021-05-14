function [  ] = mapazcm (n,pzp,np,kac)
d=50;
maxi=255;

mac=max(pzp,[],1);
mic=min(pzp,[],1);
w=mac(1,2)-mic(1,2)+2*d;
h=mac(1,3)-mic(1,3)+2*d;

im=zeros(h,w,'uint8');
for i=1:n
    y=pzp(i,2)-mic(1,2)+d;
    x=pzp(i,3)-mic(1,3)+d;
    im(x,y)=maxi;
end
figure;
imshow(im);

if(np>0)
  for i=1:np
  c(1)=pzp(kac(1,i),2)-mic(1,2)+d;
  c(2)=pzp(kac(1,i),3)-mic(1,3)+d;  
  viscircles(c,5)
  end
end


