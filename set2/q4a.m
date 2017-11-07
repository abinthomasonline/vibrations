load elcentro.mat

lag = 0:length(t)-1;
auto_correlation = zeros(1,2*length(lag)-1);

for i = lag
	sum = 0;
	count = 0;
	for j = 1:length(t)-i
		sum = sum + p(j)*p(j+i);
		count = count + 1;
	end
	auto_correlation(length(t)+i) = auto_correlation(length(t)-i) = sum/count;
end

f = 1/(t(2)-t(1));
L = length(auto_correlation);
S = abs(fftshift(fft(auto_correlation))/L);
w = (2*pi*f/L)*(-L/2:L/2-1);

plot(w, S);
