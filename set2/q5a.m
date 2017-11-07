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

FFT_p = fftshift(fft(p));
H = 1./(-m*w.^2 + i*c*w + k);
FFT_u = H.*FFT_p;
u = ifft(fftshift(FFT_u));

plot(t, u);
xlabel('t - time');
ylabel('u - response');
