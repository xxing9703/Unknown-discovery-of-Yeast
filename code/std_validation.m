% validate C7H6NO2, four stds 1-3-8-9
path='D:\LC-MS data\Yeast_RT_std';
addpath('C:\Users\xxing\Documents\GitHub\ms2cleaning');

M1=mzxml2structMS2_com(fullfile(path,'std1.mzXML'));
M2=mzxml2structMS2_com(fullfile(path,'std3.mzXML'));
M3=mzxml2structMS2_com(fullfile(path,'std8.mzXML'));
M4=mzxml2structMS2_com(fullfile(path,'std9.mzXML'));

pk.mz=165.0306; 
pk.rt=10;
settings.rtm=8;
%%
figure
[sp,intensity,rt2]=getEIC(M1(1),pk,settings);
subplot(4,1,1)
plot(sp{1}(:,1),sp{1}(:,2));


[sp,intensity,rt2]=getEIC(M2(1),pk,settings);
subplot(4,1,2)
plot(sp{1}(:,1),sp{1}(:,2));

[sp,intensity,rt2]=getEIC(M3(1),pk,settings);
subplot(4,1,3)
plot(sp{1}(:,1),sp{1}(:,2));

[sp,intensity,rt2]=getEIC(M4(1),pk,settings);
subplot(4,1,4)
plot(sp{1}(:,1),sp{1}(:,2));

%%
settings.rtm=0.3;
figure
subplot(4,1,1)
pk.rt=13.01;
pk.rt=4.1;
 ms=getMS(M1(2),pk);
 stem(ms{1}(:,1),ms{1}(:,2),'.');
 xlim([30,180]);
 
 subplot(4,1,2)
 pk.rt=7.62;
 pk.rt=4.1;
 ms=getMS(M2(2),pk); 
 stem(ms{1}(:,1),ms{1}(:,2),'.');
 xlim([30,180]);

 subplot(4,1,3)
 pk.rt=7.23;
 pk.rt=4.1;
 ms=getMS(M3(2),pk);
 stem(ms{1}(:,1),ms{1}(:,2),'.');
 xlim([30,180]);

 subplot(4,1,4)
 pk.rt=7.23;
 pk.rt=4.1;
 ms=getMS(M4(2),pk);
 stem(ms{1}(:,1),ms{1}(:,2),'.');
 xlim([30,180]);



