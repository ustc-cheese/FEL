clc;
clear all;

E=3050*0.511;
gamma=E/0.511;
N=320000;   %%%particle number
l = 270e-9;
ncycle = 10;
sigmaE = E*0.00005;
k = 2*pi/l;

z=randn(1,N)*l*ncycle;
g=randn(1,N);   %%means p in the note

R561=0.00684;
R562=0.000245245;

A1=4;
A2=4;


B1=R561*k*sigmaE/E;

B2=R562*k*sigmaE/E;

%bn
n=-1;
h=[];
b=[];
for i = 1:1:50
    j = abs(besselj(i,-(i+n)*A2*B2)*besselj(n,-A1*(n*B1+(i+n)*B2))*exp(-0.5*(n*B1+(i+n)*B2)^2));%b50
    b=[b,j];
    a = i-1;
    h=[h,a];
end
figure,scatter(h,b,20,'filled');
xlabel('n','fontsize',15) ; ylabel('b_n','fontsize',15);
ylim([0 0.5])

g=g+A1*sin(2*pi*z/l);
z= z + B1*g/k;
g=g+A2*sin(2*pi*z/l);
z= z + B2*g/k;



figure,plot(z/l,g*1e-1+gamma,'r.','markersize',0.01)
xlabel('z/\lambda_s','fontsize',15) ; ylabel('\gamma','fontsize',15);
set(gca,'FontSize',15);
xlim([0 1])

current=hist(z/l,500);
figure,plot(current)
fft_z = fft(current,500);
x=linspace(0,50,500);
figure,plot((x),abs(fft_z(1:1:500))/max(abs(fft_z)),'.-');
xlabel('n','fontsize',15) ; ylabel('b_n','fontsize',15);
set(gca,'FontSize',15)