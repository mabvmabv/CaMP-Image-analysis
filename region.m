function [ ] = region()

global all maxi
maxi=5000;
%imshow(ac,[0,maxi])
helpdlg('Use mouse to select your area');
[aMask] = roipoly();
[ra,col]=size(all);
i=1;
while i<=ra
    x=all(i,4);
    y=all(i,3);
    if aMask(x,y)==0
        all(i,:)=[];
        ra=ra-1;
    else i=i+1;    
    end
end  


