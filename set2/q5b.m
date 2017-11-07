clear all
load elcentro.mat

m = 100;
k = 400;
zeta = 0.02;
wn = sqrt(k/m);
c = 2*m*wn*zeta;
L = length(t);
dt = t(2)-t(1);
dw = (2*pi)/(dt*L);
w = dw*(-L/2:L/2-1);

y = fftshift(fft(p))/L;
S = y.*conj(y)./(2*dw);

H = 1./(-m*w.^2 + i*c*w + k);

S_u = S.*H.*conj(H);

plot(w, 2*S_u);
xlabel('w - angular frequency');
ylabel('PSDF');
