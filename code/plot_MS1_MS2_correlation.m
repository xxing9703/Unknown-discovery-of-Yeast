% input ms2info with id 
% ouput a plot shwoing the MS1-MS2 correlation plots for all
% fragments.  
% 
% fragID is optional, if specified, it will only show that fragment peak

function plot_MS1_MS2_correlation(ms2info,infoID,fragID)
if nargin<=2
    fragID=0;
end
n=length(ms2info);

if infoID>n
    fprintf(['infoID must not exceed',num2str(n),'\n']);
    return
else
    ms2dt=ms2info(infoID);
end

m=size(ms2dt.MS2_ms,1);  % total number of MS2 fragment peaks
if fragID>m
    fprintf(['fragID must not exceed',num2str(m),'\n']);
    return
else
end


if fragID==0  % show all
    x=floor(sqrt(m))+1;
    f=figure(Units="normalized",Position=[0.1,0.1,.8,.8],Name=['precursor=',num2str(ms2dt.precursor)]); 
    verbose=0;
elseif fragID<=m % show only one frag
    x=1;
    f=figure;
    m=1;
    fragID=fragID-1;
    verbose=1;
end
for item=1:m
    subplot(x,x,item)               
    eic1=ms2dt.MS2_eic(item+fragID).eic;
    eic2=ms2dt.MS1_eic.eic;
    mz=ms2dt.MS2_eic(item+fragID).mz;
     
    if sum((abs(ms2dt.MS2_ms_clean(:,1)-mz)<0.0001))
        cl='r';
    else
        cl='b';
    end        
    plot(eic2(:,1),eic2(:,3)/max(eic2(:,3)),'c')
    hold on; 
    plot(eic1(:,1),eic1(:,3)/max(eic1(:,3)),cl);
      
    title(['frag m/z=',num2str(mz)]);
    if verbose==1
        xlabel('rt');
        legend({'MS1','MS2'})
    end
end
