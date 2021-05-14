function [] = latclus1()
global fps nap ev sp mf ns hipaze hipazs
clc;
if nap~=0
    np=size(hipaze,2);
    if np~=0
    difc=zeros(mf,np);
    for i=1:np
        j=hipaze(1,i);
        xxx=find(ev(:,1)==j);
        sx=size(xxx,1);
        d=0;
        l1=1;
        for j=1:sx
            jj=xxx(j);
            l=ev(jj,2);
            d=d+1;
            difc(l1:l,i)=d;
            difc(l,i)
            l1=l;
        end
        difc(l:mf,i)=d;
    end
    for i=1:np
     x(:,i)=1:mf;
    end
    figure
    plot(x,difc);
    save('difce','difc','-ascii')
    end
end 

    np=size(hipazs,2);
    if(np~=0)
    figure
    difcs=zeros(mf,np);
    for i=1:np
        j=hipazs(1,i);
        xxs=find(sp(:,1)==j);
        sx=size(xxs,1);
        d=0;
        l1=1;
        for j=1:sx
            jj=xxs(j);
            l=sp(jj,2);
            d=d+1;
            difcs(l1:l,i)=d;
            l1=l;
        end
        difcs(l:mf,i)=d;
    end
    plot(1:mf,difcs);
    save('difcs','difcs','-ascii');
    end
    end