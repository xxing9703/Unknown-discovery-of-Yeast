DT1=DT(DT(:,8)==1,:);
for i=1:size(DT1,1)
    DT1(i,9)=mod(round(DT1(i,7)),2);
    DT1(i,10)=mod(round(DT1(i,2)),2);
    DT1(i,11)=abs(DT1(i,10)-DT1(i,9));
end

ct=0;
for i = 100:50:800
    ct=ct+1;
    DT2=DT1(DT1(:,7)<i,:);
    tp(ct,1)=i;
    tp(ct,2)=length(find(DT2(:,11)==0))/size(DT2,1);
    
end

figure, plot(tp(:,1),tp(:,2),'-*')
xlabel('m/z')
ylabel('odd/even Nitrogen rule accuracy')
