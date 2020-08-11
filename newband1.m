clc;
clear all;

np = 16000;
gamma = 3053;
sigma = 5e-5;
delgam = sigma*gamma;
lambda = 270e-9;

p_pure = randn(1,np);
z_pure = rand(1,np)*lambda;
A = 4;

p_pure = p_pure + A*sin(2*pi*z_pure/lambda);
z_pure =  z_pure + 0.0072*p_pure*0.005e-2;
z_pure = mod(z_pure,lambda)/lambda;

figure,plot(z_pure,p_pure,'r.','markersize',0.001);
xlabel('z/\lambda_s','fontsize',15) ; ylabel('\gamma','fontsize',15);

k = 2*pi/lambda;

R56 = linspace(0,1e-2,1e4);
h=[];
b=[];
n = 1;
for i = 1:1:1e4
    B = k*sigma*R56(i);
    bn = abs(besselj(n,-A*B*n)*exp(-0.5*B^2*n^2));
    b = [b,bn];
    h = [h,B];

end
B = 3.2579

bn = abs(besselj(n,-A*B*n)*exp(-0.5*B^2*n^2))
figure,plot(h,b,'r','LineWidth',2);
xlabel('B','fontsize',15) ; ylabel('b_n','fontsize',15);
set(gca,'YTick',[0:0.2:1])
