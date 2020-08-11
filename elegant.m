clc;
clear all

%GENESIS simulation parameters
c = 3e8;
gamma = 3053;
nslices = 0;
nslice = 556;
np = 8000;

AA = zeros(np,6);
z = zeros(np*nslice,1);
p = zeros(np*nslice,1);
x = zeros(np*nslice,1);
y = zeros(np*nslice,1);
xp = zeros(np*nslice,1);
yp = zeros(np*nslice,1);
FID1 = fopen('m1.out.dpa');
for i = 1:1:nslices
    AA = fread(FID1,[np,6],'double');
end
for i = 1:1:nslice
    AA = fread(FID1,[np,6],'double');
    for j = 1:1:np
        z(j+(i-1)*np) = AA(j,2)+2*pi*(i-1);
        p(j+(i-1)*np) = AA(j,1);
        x(j+(i-1)*np) = AA(j,3);
        xp(j+(i-1)*np) = AA(j,5);
        y(j+(i-1)*np) = AA(j,4);
        yp(j+(i-1)*np) = AA(j,6);
    end
end

z = (mod(z,nslice*2*pi)/nslice/2/pi)*(270e-9*nslice);
figure,plot(z,p,'r.','markersize',0.001);
xlabel('z','fontsize',15) ; ylabel('p','fontsize',15);
set(gca,'FontSize',15);

eminx_x = (mean(x.^2)*mean(xp.^2)-(mean(x.*xp))^2)^0.5;     %nomalized emittance in x-aixs
eminx_y = (mean(y.^2)*mean(yp.^2)-(mean(y.*yp))^2)^0.5;     %nomalized emittance in y-aixs
fclose(FID1);

p = (p-gamma)/0.005e-2/gamma;
z = z + 0.0073*p*0.005e-2;

%write dpa after ds1, ds2
BB = [z,p,x,y,xp,yp];


z9 = BB(:,1);
p9 = BB(:,2);
x9 = BB(:,3);
xp9 = BB(:,5)/gamma;
y9 = BB(:,4);
yp9 = BB(:,6)/gamma;

emix_x9 = (mean(x9.^2)*mean(xp9.^2)-(mean(x9.*xp9))^2)^0.5;     %geometry emittance in x-aixs
emix_y9 = (mean(y9.^2)*mean(yp9.^2)-(mean(y9.*yp9))^2)^0.5;     %geometry emittance in y-aixs

p9 = gamma+p9*0.005e-2*gamma;


figure,plot(z9/270e-9,p9,'r.','markersize',0.001);
xlabel('z/\lambda_s','fontsize',15) ; ylabel('\gamma','fontsize',15);
set(gca,'FontSize',15);
xlim([100 110])
set(gca,'YTick',[3049:1:3058])


% % write dpa file
theta  = 2*pi;
t = z9/c;
BB = [x9,xp9,y9,yp9,t,p9];

sdds = fopen('r1.sdds','w');
[m,n] = size(BB); 
for i = 1:1:m
    for j = 1:1:n
        if j == n
            fprintf(sdds,'%d\n',BB(i,j));
        else
            fprintf(sdds,'%d\t',BB(i,j));
        end
    end
end

figure,plot(t,p9,'r.','markersize',0.001);
xlabel('t','fontsize',15) ; ylabel('x','fontsize',15);

emix_x = (mean(x9.^2)*mean(xp9.^2)-(mean(x9.*xp9))^2)^0.5;      %check out geometry emittance in x-aixs
emix_y = (mean(y9.^2)*mean(yp9.^2)-(mean(y9.*yp9))^2)^0.5;      %check out geometry emittance in y-aixs

fclose(sdds);

figure,plot(t,p9,'r.','markersize',0.001);
xlabel('t','fontsize',15) ; ylabel('p','fontsize',15);
set(gca,'FontSize',15);
current = hist(t,500);
figure,plot(current)
fft_z = fft(current,500);
figure,plot((1:1:500),abs(fft_z(1:1:500))/max(abs(fft_z)),'.-');
xlabel('n','fontsize',15) ; ylabel('b_n','fontsize',15);
set(gca,'FontSize',15)
