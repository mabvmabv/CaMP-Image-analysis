clc
close all;
clear all;
fclose('all');

tsec=300;     % seconds overall
res=25;   % steps 1/s
detres=3;  % time-point for minimal imaging resolution
t=tsec*res;   % n of steps
lat=zeros(2,1); % initialize diff array
evc=zeros(1000,1);  %computed distribution entries
frev=xlsread('gv58-freqev');  %%data distribution entries
latex=xlsread('latencies-gv58');            %%data latencies

n=4500;        % N LAZ
op=8500;      % 1/ low p
ophc=25000;      % 1/p conversion to high
opbl=500;     % 1/p conversion back to low
ophr=3000;        %1/p release from high
opsc=55;
opbs=8;
opsr=23;
rnumb= [281513 81513 8113 81173 821173 82173 821739 21739 1739 17396]
irrr=rnumb(1,2)
rng(irrr)
%%
%rng(82173);

nco=0;     %event count
nhco=0;    %high event count;
nhso=0;    %fast event count;
for irand=1:10
    irrr=rnumb(1,irand)
    rng(irrr)
    evc=zeros(1000,1);
    lat=zeros(2,1);
    
for az=1:n 
  tim=zeros(2,1);
  thp=[];
  tsp=[];
  timl=[];
  nhev=0;                       %number of high releases 
  nseq=0;                       %number of seqential releases    
  ec=random('unid',ophc,t,1);
  tc=find(ec==ophc);             % times of conversions
  td=tc;                          % times of deconversions 
  ncpaz=length(tc);               % ncpaz number of conversions 
  opblr=round(random('norm',opbl,opbl/3.,1,ncpaz));
  ophlr(find(opblr<2))=2;
  
  for ic=1:ncpaz         
     eb=random('unid',opblr(ic),t,1); 
     cb=find(eb==opblr(ic));          % deconversions     
     td(ic)=t;
     if isempty(cb)==false && min(cb)<td(ic)-tc(ic)
          td(ic)=tc(ic)+min(cb) ;                     % deconversion timing 
     end
  end  
  ic=1;
  while ic<ncpaz                  % overlapping conversions
     while ic<ncpaz && td(ic)>tc(ic+1)
       td(ic)=td(ic+1);
       tc(ic+1)=[];
       td(ic+1)=[];
       ncpaz=ncpaz-1;
     end    
     ic=ic+1;
  end
  ophrr=round(random('norm',ophr,ophr/6., 1, ncpaz));
  ophrr(find(ophrr<2))=2;
  for ic=1:ncpaz                   % high p releases
     er=random('unid',ophrr(ic),td(ic)-tc(ic),1);
     ch=find(er==ophrr(ic));             % timings of highp release in the interval   
     thpic=ch; 
     nhev=nhev+length(ch);              % number of high p events     
     thpic=thpic+tc(ic);                   % actual timings of highp release   
     thp=cat(1,thp,thpic);     
     
     es=random('unid',opsc,td(ic)-tc(ic),1);  % fast conversions 
     ts=find(es==opsc);        % times of conversions
     ts=ts+tc(ic);
     tds=ts;                          % times of deconversions 
     ncs=length(ts);               % ncs number of conversions 
     for is=1:ncs   
       ebs=random('unid',opbs,t,1); 
       sb=find(ebs==opbs);          % fast deconversions     
       tds(is)=td(ic);
       if isempty(sb)==false && min(sb)<tds(is)-ts(is)
          tds(is)=ts(is)+min(sb) ;                     % deconversion timing 
       end         
       ers=random('unid',opsr,tds(is)-ts(is),1);
       chs=find(ers==opsr);             % timings of fast release in the interval
       tseq=chs;
       nseq=nseq+length(chs);              % number of fast p events       
       tseq=tseq+ts(is);                % actual timings of fast release 
       tsp=cat(1,tsp,tseq);   
    end 
  end
  
  e=random('unid',op,t,1);
  timl=find(e==op);          % timings of low releases
  if isempty(timl)==false
   for ic=1:ncpaz
     il=1;  
     while isempty(timl)==false && il<=length(tim) && tim(il)>tc(ic) && tim(il)<=td(ic) 
        timl(il)=[];           %eliminating lows releases within high intervals 
     end 
     il=il+1;
   end
  end  
  nev=length(timl);                % number of low releases    
  
  tim=cat(1,tim,timl,thp,tsp);
  tim(find(tim==0))=[];
    
  nhco=nhco+nhev;
  nhso=nhso+nseq;
  nco=nco+nev;
  tim=sort(tim);           % timings of events
  tim(find(tim>t))=[];                   % elimination of late events                   
  neval=length(tim);
  d=diff(tim);  % latencies     
  i=0;
  while i<neval         % elimination of undetected due to resolution
        i=i+1;    
        while i<neval && d(i)<detres
          tim(i+1)=[];
          d(i)=[];
          neval=neval-1;
        end   
  end  
  d=diff(tim);
  if isempty(d)==false
    lat=cat(1,lat,d);                         %latencies 
  end
  if(neval>0)
          evc(neval,1)=evc(neval,1)+1;    % distribution
  end  
end
lat(find(lat==0))=[];

nb=1:(tsec+1);
edges=(nb-1)*res;
counts=histcounts(lat,edges);
counts1=histcounts(latex,edges);
nb=1:tsec;
centers=nb*res;
figure;
plot(centers, counts1, centers, counts);   %distribution of latencies

slat=min(size(counts1, 2), size(counts, 2));
chilat=(counts1(1,1:slat)-counts(1,1:slat)).*(counts1(1,1:slat)-counts(1,1:slat)) ;
for i=1:slat
  if counts1(1,i)>0 
      chilat(1,i)=chilat(1,i)/counts1(1,i);
  else 
      chilat(1,i)=0;
  end    
end
chla2=sum(chilat)               % chi2 latencies
slat
counts1(1,1)-counts(1,1)

s=min(size(frev, 1), size(evc, 1));
chid=(frev(1:s,1)-evc(1:s,1)).*(frev(1:s,1)-evc(1:s,1)) ;
for i=1:s
  if frev(i,1)>0 
      chid(i,1)=chid(i,1)/frev(i,1);
  else 
      chid(i,1)=0;
  end    
end
ch2=sum(chid)               % chi2  
s

nreal=0;                     % number of events - data 
for i=1:size(frev, 1); 
 nreal=nreal+i*frev(i,1);
end

nreal      %number of events: data
sum(frev)  %number of AZ: data
nco        %number of low events: MC
nhco       %number of high events: MC 
nhso       % number of fast event: MC
sum(evc)   %number of AZ: MC

figure;
plot(1:s, frev(1:s,1), 1:s, evc(1:s,1));   %distribution of events
 
bc=zeros(500,2);                                 % bursts 1:MC; 2:exp
b=find(lat<=res);  
bs=length(b);
ii=2;                                  % within a burst -initiation
iit=1;                                 % overall counts
while (iit<bs)
     while iit<bs && (b(iit+1)==b(iit)+1) 
        iit=iit+1;
        ii=ii+1;
     end   
     bc(ii,2)=bc(ii,2)+1;
     if ii==2
         iit=iit+1;
     end
     ii=2;
end

b=find(latex<=res);  
bs=length(b);
ii=2;                                  % within a burst -initiation
iit=1;                                 % overall counts
while (iit<bs)
     while iit<bs &&(b(iit+1)==b(iit)+1)  
        iit=iit+1;
        ii=ii+1;
     end   
     bc(ii,1)=bc(ii,1)+1;
     if ii==2
         iit=iit+1;
     end
     ii=2;
end

s=10;
figure;
semilogy(2:s, bc(2:s,1), 2:s, bc(2:s,2));   %bursts  
end  


