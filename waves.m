function [] = waves()
global pz sp fps nz azw wa hipazs
nw=0;
[sdi,~]=size(sp);
azw=zeros(sdi,nz);
wa=zeros(sdi,2);
f=fopen('waves','w');
fps=25;
cut=4;
cw=4*cut;
fsp=sortrows(sp, 2);
fsp(:,3)=[];
caz=fsp(1,:);
fsp(1,:)=[];
w=-1;
while isempty(fsp)==0
 cazxy=pz(caz(1,1),2:3) ;
 [nextev,~]=find( (fsp(:,2)-caz(1,2) <= fps) & (fsp(:,2)-caz(1,2) >= 0) )   ;
 if isempty(nextev)==1
   caz=fsp(1,:);
   fsp(1,:)=[];
   if w==1
    w=0;
   end 
 else
  aznex=pz(fsp(nextev,1),2:3);
  d=[];
  for k=1:size(nextev,1)
   d(k,1)=norm(aznex(k,:)-cazxy);
  end
  [xxx,~]=find(d<cw);
  if isempty(xxx)==1
    caz=fsp(1,:);
    fsp(nextev(1),:)=[];
    if w==1
      w=0;
    end 
  else
    if(w<1)
        nw=nw+1;
    end    
    w=1;
    k=nextev(xxx(1));  
    dd=d(xxx(1),1);
    fprintf(f,'%6d %6d %6d %6d   %6.2f\n', caz(1,1), fsp(k,1), caz(1,2), fsp(k,2), dd );
    wa(nw,1)=wa(nw,1)+1;
    wa(nw,2)=wa(nw,2)+round(dd);
    azw(nw,wa(nw,1))=caz(1,1);
    azw(nw,wa(nw,1)+1)=fsp(k,1);
    caz=fsp(k,:);
    fsp(k,:)=[];
   end
 end 
 if w==0
    fprintf(f,'\n');
    w=-1;
 end 
 
end
[xxx,~]=find(wa(:,2)==0);
wa(xxx,:)=[];
azw(xxx,:)=[];
w1=wa(:,1);
fprintf(f,'Stats\n');
fprintf(f,'%6d\n', size(w1,1));
lw=max(w1);
x=1:(lw+1);
xe=x-0.5;
wc=histcounts(w1,xe);
x(lw+1)=[];
fprintf(f,'%6d ', x+1) ;
fprintf(f,'\n');
fprintf(f,'%6d ', wc);

h=figure;
colordef(h,'white');
plot(pz(:,2),-pz(:,3),'black.'); 
axis equal; axis off; 
hold on;

lz=zeros(1,lw);
for k=1:size(w1,1)
  azn0=azw(k,:);
  xxx=find(azn0==0);
  azn0(xxx)=[];
  [~,lzc]=size(setdiff(azn0,hipazs));
  [~,ind]=size(azn0);
  if ind>lw-3
     plot(pz(azn0,2),-pz(azn0,3),'Color',[rand,rand,rand], 'Linewidth', 2); 
     hold on;
  end    
  ind=ind-1;
  lz(1,ind)=lzc+lz(1,ind);
end  
tc=double((x+1).*wc);
lzp=(1-double(lz)./tc)*100;
fprintf(f,'\n');
fprintf(f,'%6.1f ', lzp);
fclose(f);

% h=figure;
% colordef(h,'white');
% [xxx,~]=find(wa(:,1)==lw)
% lwaz=azw(xxx(1),:).';
% lwaz(lwaz==0)=[];
% 
% plot(pz(lwaz,2),-pz(lwaz,3),'r', pz(:,2),-pz(:,3),'black.','Linewidth', 2); 
% axis equal; axis off; 
% hold on;
% 
% [xxx,~]=find(wa(:,1)==lw-1);
% lwaz=azw(xxx(1),:).';
% lwaz(lwaz==0)=[];
% plot(pz(lwaz,2),-pz(lwaz,3),'g', 'Linewidth', 2); 
% 
% hold on;
% 
% [xxx,~]=find(wa(:,1)==lw-2);
% lwaz=azw(xxx(1),:).';
% lwaz(lwaz==0)=[];
% plot(pz(lwaz,2),-pz(lwaz,3),'b', 'Linewidth', 2); 


end
