load elcentro.mat %load elcentro data

AC = xcov(p, length(p)-1); %autocorrelation

S = abs(fft(AC)); %absolute value of discrete fourier transform of AC

plot(S);
