function [] = threshold()
 global nfp fcount aveb level w h maxi a bsa frperc maim
 
  answer=inputdlg({'Number of frames to analyse?'}, 'visual', 1, {'500'});
  frperc = str2num(answer{1});
  if fcount+frperc>nfp 
     frperc=nfp-fcount;
  end
  stfr=fcount+1;
  last=fcount+frperc;
  svid=zeros(w,h,'double');
  for i=stfr:last   
   adf(i);
   df=cast(a,'double');
   svid=svid+df;
  end
  
  ave=round(svid./frperc);
  aveb=cast(ave,'uint16'); 
  imshow(aveb,[0,maxi])  ;

  nfba=3;
  bsa=zeros(w,h,nfba,'double');
  for ii=1:nfba
    i=ii+fcount;
    adf(i);
    bsa(:,:,ii)=df-ave;
  end
  
  t=max(max(max(bsa)))
  td=t*0.6;
  figure
  hist(bsa)
  prompt={'Enter threshold for background:'} ;
  title='threshold' ;
  def={num2str(td)} ;
  answer=inputdlg(prompt,title, 1, def);
  al = str2num(answer{1});
k=al(1);
rt=min(t,k);
level=rt/maim;
end

