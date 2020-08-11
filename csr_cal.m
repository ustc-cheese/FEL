clc;
clear all

%parameters
N =  1.1742e+10;      %paticle number
c = 299792458;
E = 1600;
e0 = 1.602176634e-19;

gamma = 1600/0.511;
lambda = 0.04;
xlambdas = 9e-9;
sigma = 1.5e-04;
kw = 2*pi/lambda;
K =  2.6185;
p = gamma^2*kw*sigma/(1+K^2/2);
C = 0.577;
syms xp yp real

x = linspace(0,5,1000);
%pre func
fun = @(x)int(exp((xp).^2./2)*(1+erf(xp./sqrt(2))), xp, 0, x);
Hx = arrayfun(fun,x);
Fx = 1/4*(C+3*log(2)-2).*x.*exp(-x.^2/2)-sqrt(pi/8).*(1+erf(x./sqrt(2))-x.*exp(-x.^2/2).*Hx);
Gx = x/2.*exp(-x.^2/2)*log(p)+Fx;
deltax = c*e0^2*N^2*K^2/(sqrt(2*pi)*sigma^2*gamma^2)*Gx;

y = linspace(-5,0,1000);
%pre func
fun = @(y)int(exp((yp).^2./2)*(1+erf(yp./sqrt(2))), yp, y, 0);
Hy = arrayfun(fun,y);
Fy = 1/4*(C+3*log(2)-2).*y.*exp(-y.^2/2)-sqrt(pi/8).*(1+erf(y./sqrt(2))-y.*exp(-y.^2/2).*Hy);
Gy = y/2.*exp(-y.^2/2)*log(p)+Fy;
deltay = c*e0^2*N^2*K^2/(sqrt(2*pi)*sigma^2*gamma^2)*Gy;

s = [y,x];
Energychange = [deltay,deltax];
figure,plot(s,Energychange);

xlabel('Normalized Beam Position','fontsize',15) ; ylabel('Normalized Energy Change','fontsize',15);
