load elcentro.mat %load elcentro data

AC = zeros(1,2*length(p)-1); %Autocorrelation matrix
T = [-1.*flip(t),t(2:end)]; %Time axis

for i=1:1:length(p) %right shifted multipplication
	AC(i:i+length(p)-1) = AC(i:i+length(p)-1) + p.*p(length(p)-i+1);
end

for i=1:1:length(p)-1 %dividing with frequency
	AC(length(AC)-i+1) = AC(length(AC)-i+1)./i;
	AC(i) = AC(i)./i;
end
AC(length(p)) = AC(length(p))./length(p);

plot(T,AC); %plot
