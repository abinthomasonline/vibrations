load elcentro.mat %load elcentro data

%%%%%%%%%%% Auto-Correlation %%%%%%%%%%%
AC = zeros(1,2*length(p)-1); %Autocorrelation matrix
T = [-1.*flip(t),t(2:end)]; %Time delay axis

for i=1:1:length(p) %right shifted multipplication
	AC(i:i+length(p)-1) = AC(i:i+length(p)-1) + p.*p(length(p)-i+1);
end

for i=1:1:length(p)-1 %dividing with frequency
	AC(length(AC)-i+1) = AC(length(AC)-i+1)./i;
	AC(i) = AC(i)./i;
end
AC(length(p)) = AC(length(p))./length(p);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

S = abs(fft(AC)); % magnitude of fourier transform 
dw = (2*pi)/(t(end)-t(1)); % increment in frequency
w = ((1-length(S))/2:(length(S)-1)/2).*dw; % frequency axis
plot(w,S);
