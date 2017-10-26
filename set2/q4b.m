load elcentro.mat %load elcentro data

S = (abs(fft(p)).^2).*(t(end)/(4*pi));

w = lag.*((2*pi)/(length(AC)*dt)); %angular frequency axis

plot(w, S);
