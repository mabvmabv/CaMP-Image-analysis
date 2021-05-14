function [] = cleansm()
global binfr

minpix=5;
CCI = bwconncomp(binfr);
    numPixels = cellfun(@numel,CCI.PixelIdxList);
    sr=size(numPixels);
    for ip=1:sr(2)
       if numPixels(ip)<minpix
         binfr(CCI.PixelIdxList{ip}) = 0;
       end
    end
end

