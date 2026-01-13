function [frag,ct,explained,ms2out]=get_frag_formula(ms2,formula,ppm,mode)
ct=0;
explained=0;
ms2out=[];
sig=0;
if isempty(ms2)
    frag=[];
    return;
end
[mass,~,count]=formula2mass(formula);

for i=1:size(ms2,1)
    mz=ms2(i,1);
    loss=mass-mz+1.00728*mode;
    frag{i,1}=mz;
    frag{i,2}='';
    frag{i,3}=loss;
    frag{i,4}='';

    out=mass2formula_CN(mz,[0,count(1)],[0,count(2)],ppm*sqrt(400/mz),mode);       
    if ~isempty(out)        
       for j=1:size(out,1)          
           ff=out{j,1};                
           [~,~,count1]=formula2mass(ff);
           if sum(count1<=count)==length(count)
               count2=count-count1;
               frag{i,2}=[frag{i,2},ff,' '];
               out2=mass2formula_CN(loss,[count2(1),count2(1)],[count2(2),count2(2)],ppm*sqrt(400/loss),0);
               if ~isempty(out2)
                 frag{i,4}=[frag{i,4},out2{1,1},' '];
               end
           end
       end
    end
    if ~isempty(frag{i,2})
        ct=ct+1;
        sig=sig+ms2(i,2);
        ms2out=[ms2out;ms2(i,:)];
    end
end
explained=sig/sum(ms2(:,2));

