load elcentro.mat %load elcentro data

S = (abs(fft(p)).^2).*(t(end)/(4*pi));

dt = t(2)-t(1);

w = (1-length(p):2:length(p)-1).*((2*pi)/(length(AC)*dt)); %angular frequency axis

plot(w, S);
