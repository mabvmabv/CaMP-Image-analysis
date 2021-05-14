function regions( kk )
global aveb level maxi a binfr
  
    close all;
    adf(kk);
    figure;
    imshow(a,[0,maxi]);
       
    figure;
    a=abs(a-aveb);
    imshow(a, [0,maxi]);
    
    figure;
    binfr=im2bw(a,level);
    imshow(binfr);
    
    figure;
    cleansm();
    imshow(binfr);
    input('continue?')
    
end

