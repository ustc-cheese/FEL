%elegant.readout
clc;
clear all;

c = 3e8;
system('sddsconvert r1.out r1.beam -ascii')
out = fopen('r1.beam');
FormatString = '%f %f %f %f %f %f %f %*[^\n]';
data = textscan(out,FormatString,'HeaderLines',24);
phasespace = cell2mat(data);
fclose(out);
x = phasespace(:,1);
xp = phasespace(:,2);
y = phasespace(:,3);
yp = phasespace(:,4);
t = phasespace(:,5);
p = phasespace(:,6);
t = (t-3.9227e-08)*c;
t = t/270e-9-152.5403;
figure,plot(t,p,'r.','markersize',0.001);
xlabel('z/\lambda_s','fontsize',15) ; ylabel('\gamma','fontsize',15);
xlim([100 120])
set(gca,'YTick',[3049:1:3058])
set(gca,'FontSize',15);