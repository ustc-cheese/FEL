clc;
clear all

global m e c;
m = 9.10938356e-31;
e = 1.602176634e-19;
c = 299792458;

output = fopen('F:\remotefiles\r2.out');
FormatString = '%f %*[^\n]';
data = textscan(output,FormatString,'HeaderLines',168);
data = double(cell2mat(data));

recordnumber = data(1);
nslice = data(2);
lambda = data(3);
lambda_s = data(4);
meshgrid =data(6);
np = data(7);
clear data
clear FormatString

FormatString = '%f %f %f';
undulator_para = textscan(output,FormatString,'HeaderLines',1,'Delimiter','\t');
clear FormatString

FormatString = '%f %f %f %f %f %f %f %f %f %f %f';
slice = 1;
current = [];
power = [];
bunching = [];
for i = 1:1:nslice
    cur = textscan(output,'%f %*[^\n]','HeaderLines',2);
    cur = double(cell2mat(cur));
    current = [current cur];
    data = textscan(output,FormatString,'HeaderLines',1);
    slice = slice+1;
    data = double(cell2mat(data));
    power = [power data(recordnumber,1)];
    bunching = [bunching data(recordnumber,7)];
end

gamma = 3053;
curlen = 150e-6;        %rms bunch length(m)
repetition = 2;     %repitition of the seed laser(Hz)
dt = curlen/nslice/c;
s = linspace(0,curlen,nslice)*1e6;
spectral = fft(s);

figure,plot(s,bunching);
xlabel('s[\mu m]','fontsize',15) ; ylabel('bunching factor','fontsize',15);
set(gca,'FontSize',15)
xlim([0 200])
figure,plot(s,power);
xlabel('s[\nu m]','fontsize',15) ; ylabel('P[W]','fontsize',15);
set(gca,'FontSize',15)
xlim([0 200])
figure,plot(spectral,power);
xlabel('\lambda [nm]','fontsize',15) ; ylabel('intensity','fontsize',15);
set(gca,'FontSize',15)