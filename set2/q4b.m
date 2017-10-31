load elcentro.mat %load elcentro data

dt = t(2)-t(1); f = 1/dt;

S = abs(fft(p)).^2; %square of discrete fourier transform of p

w = -f/2:f/length(p):f/2-f/length(p); %frequency axis

plot(2*pi*w, S); %plot
