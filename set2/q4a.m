load elcentro.mat %load elcentro data

[AC, lag] = xcorr(p); %autocorrelation

S = abs(fft(AC)); %absolute value of discrete fourier transform of AC

w = lag.*((2*pi)/(length(AC)*dt)); %angular frequency axis

plot(w, S); %plot
