load elcentro.mat

L = length(p);
dt = t(2)-t(1);
dw = (2*pi)/(dt*L);
w = dw*(-L/2:L/2-1);

y = fftshift(fft(p))/L;
S = y.*conj(y)./(2*dw);

plot(w, 2*S);
xlabel('w - angular frequency');
ylabel('PSDF');
