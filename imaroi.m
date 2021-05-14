function [] = imaroi(np,pp)
global maxi a ac

ac=a;
  for i=1:np
      ix=pp(1,i);
      iy=pp(2,i);
    ac(iy,ix)=maxi;
   end  
  figure
  imshow(ac,[0,maxi]);
  np

