load elcentro.mat %load elcentro data

AC = xcorr(p); %autocorrelation

S = abs(fft(AC)); %absolute value of discrete fourier transform of AC

plot(S);
