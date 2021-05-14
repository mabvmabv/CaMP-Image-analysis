function [  ] = adf(i)
global a maim mask flpt
  a=imread(flpt,i);
  a( a==maim )=0;    
  a(find(mask==0))=0;
end

