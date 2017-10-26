load elcentro.mat %load elcentro data

dt = t(2)-t(1);

[AC, lags] = xcorr(p);

plot(lags.*((2*pi)/(dt*length(AC))),AC); %plot
