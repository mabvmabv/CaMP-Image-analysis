function regionsauto( kk)
global aveb roi a level binfr

    adf(kk);
    a=abs(a-aveb);
    binfr=im2bw(a,level);
    cleansm();
    CC = bwconncomp(binfr);
    roi=regionprops...
      (CC,a,'Area','WeightedCentroid','MaxIntensity','MeanIntensity');
end

