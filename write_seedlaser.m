clc;
clear all

c=299792458;

zsep = 1;         % slice separation
zmod = 1.6;     %调制段长度

%生成高斯光束
lambdas = 270e-9;
nslice = ceil(75e-6/lambdas);

power1 = 200e6;       %峰值功率（W）
% power2 = 50e6;
pulselength = 30e-15;      %种子激光脉冲长度
sigma = pulselength/2.35;
zstep = zsep*lambdas/c;
s = zstep:zstep:zstep*nslice;
s = s';
s0=((nslice-1)/2)*zstep;
prad0 = power1*exp(-((s-s0)./sigma).^2/2)...
%     + power2*exp(-((s-s0*4/3)./sigma).^2/2);
s = s*c*1e6;

figure,plot(s,prad0,'r','LineWidth',2)
xlabel('s[\mu m]','fontsize',15) ; ylabel('P[W]','fontsize',15);
set(gca,'FontSize',15);
xlim([0 75])
ylim([0 2e8])

zrayl = 48.0266+zeros(nslice,1);        %瑞利长度
zwaist = zmod/2+zeros(nslice,1);        %束腰位置
waist = sqrt(zrayl*lambdas)/pi;     %束腰大小

phase = s/1e6*2*pi/lambdas;
parameter1 = [s/1e6 prad0 zrayl zwaist phase];
parameter1 = parameter1';

%write seed.txt
seed = fopen('seed1.txt','w');
headline = fprintf(seed,'%s %s\n%s %s %d\n%s %2s %2s %2s %2s %2s %2s\n', ...
'?','VERSION = 1.0', ...
'?','size =', nslice,  ...
'?','columns','ZPOS','PRAD0','ZRAYL','ZWAIST','PHASE');
parameter1 = fprintf(seed,'%d %2d %2d %2d %2d\r\n',parameter1);
fclose(seed);

%write current.txt
% parameter2 = [s gamma zrayl beamcurrrent phase];
% beamcurrrent = hist(nslice);
% parameter2 = parameter2';
% 
% current = fopen('current.txt','w');
% current = fprintf(current,'%2d %2d %2d %2d %2d %2d %2d %2d %2d %2d %2d %2d %2d %2d %2d\r\n',parameter2);
