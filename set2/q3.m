load elcentro.mat %load elcentro data

AC = xcov(p,length(p)-1);

plot(AC); %plot
