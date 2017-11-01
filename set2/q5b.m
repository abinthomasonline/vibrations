load elcentro.mat %load elcentro data

k = 400;
m = 100;
zeta = 0.02; %damping ratio
wn = sqrt(k/m);
c = 2*m*wn*zeta;

dt = t(2)-t(1); f = 1/dt;

S = fft(p).^2; %square of discrete fourier transform of p

w = 0:f/length(p):f-f/length(p); %frequency axis
w = 2*pi*w;
H = 1./((k-m.*w.*w).^2 + (c.*w).^2); %transfer function square

w = -f/2:f/length(p):f/2-f/length(p); %frequency axis
w = 2*pi*w;
Su = H.*S;
plot(w, abs(fft(real(ifft(Su)))));
