K = 1.78728*1.414;
a = 1.2*K+1/(1+1.33*K+0.4*K^2);
h = 1.05457266e-34;
m=9.10938356e-31;
c=299792458;
L = 0.04*74*3;
rc=2.8179e-15;
k=2*pi/0.04;
gamma=3053;
b = [7*h/(15*m*c)*L*rc*gamma^4*k^3*K^2*a]^(-1/2);
