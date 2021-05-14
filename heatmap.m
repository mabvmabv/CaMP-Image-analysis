function [  ] = heatmap(  )

global pz pcuts pcute ns nap hipazs hipaze bot pcuts nz

[~,ix] = sort(pz(:,5),'ascend');
ps = pz(ix,:)/ns;

if nap~=0
[~,ix] = sort(pz(:,4),'ascend');
pe = pz(ix,:)/double(nap);
h=figure;
colordef(h,'black');
scatter(pe(:,2),-pe(:,3),30 ,pe(:,4), 'filled'); colorbar; axis equal; axis off; caxis([0 pcute]); 
end


h=figure;
colordef(h,'white');
scatter(ps(:,2),-ps(:,3),40 ,ps(:,5), 'filled'); 
colorbar; axis equal; axis off; caxis([0 1.3*pcuts]); colormap (jet);
d=zeros(nz,1); d=d+0.2;
xxx= (ps(:,5)>=pcuts) ; 
d(xxx,1)=1.;
h=figure;
colordef(h,'white');
scatter(ps(:,2),-ps(:,3),40 ,d(:,1), 'filled'); 
axis equal; axis off; caxis([0 1.1]); colormap (jet);

if nap~=0
eo=setdiff(hipaze,bot)
so=setdiff(hipazs,bot)
phe=pz(eo,:);
phs=pz(so,:);
phb=pz(bot,:);
phe(:,4)=1;
phs(:,4)=2;
phb(:,4)=3;
phes=union(phe,phs,'rows');
ph=union(phes,phb,'rows');

h=figure;
colordef(h,'black');
scatter(ph(:,2),-ph(:,3),40 ,-ph(:,4), 'filled'); axis equal; axis off; caxis([1 3]);
end

