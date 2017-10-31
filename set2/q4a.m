load elcentro.mat %load elcentro data

AC = xcorr(p); %autocorrelation

dt = t(2)-t(1); f = 1/dt;

S = abs(fft(AC)); %absolute value of discrete fourier transform of AC

w = -f/2:f/length(AC):f/2-f/length(AC); %frequency axis

plot(2*pi*w, S); %plot
