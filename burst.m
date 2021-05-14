function [] = burst()
global fps sp hipazs

fba=zeros(2,1);
mabc=100;
abco=zeros(mabc,1);
hipazs
np=size(hipazs,2)
if(np~=0)
 f=fopen('bursts', 'w');
 for i=1:np
   j=hipazs(1,i);
   sf=sp(find(sp(:,1)==j),2);
   fb=sp(find(sp(:,1)==j),3);
   l=diff(sf);
   b=find(l<fps);
   [bs,~]=size(b);
   if(bs>0)
     fba=vertcat(fba,fb);
     iit=2;
     ii=1;
     bc=[];
     bc(ii)=2;
     sbc=bs;
     while ii<=sbc && iit<=bs
       if b(iit)-1~=b(iit-1) 
           iit=iit+1;
       else    
        while (iit<=bs) && (b(iit)-1==b(iit-1)) 
          bc(ii)=bc(ii)+1;
          iit=iit+1;
          sbc=sbc-1;
        end  
       end 
       ii=ii+1;
       if ii<=sbc
           bc(ii)=2;
       end    
      end
 
     for ii=1:sbc
       jj=bc(ii);  
       abco(jj,1)=abco(jj,1)+1;
     end
   abco(1,1)=abco(1,1)+size(sf,1)-size(b,1);
        fprintf(f,'\n %5d              ',j);
     fprintf(f,'%4d',bc );
     fprintf(f,'\n\n');
     fprintf(f,'%6d',sf);
     ff=sp(find(sp(:,1)==j),3);
     fprintf(f,'\n');
     fprintf(f,'%6d',ff);
     fprintf(f,'\n\n');
   end
   
 end
 
  ne=mabc;
     while abco(ne,1)==0   
         ne=ne-1;
     end
     ne=ne+1;
     abco(ne:mabc)=[];
     
     fprintf(f,'\n\n');
     fprintf(f,'%6d',abco);   
 
 fclose(f); 
end
fba(fba==0)=[];
fall=sp(:,3);
save('fbursts','fba','-ascii')
save('fall','fall','-ascii')
end