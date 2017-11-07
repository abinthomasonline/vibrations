load elcentro.mat
L = length(t);
lag = 0:L-1;
auto_correlation = zeros(1,2*L-1);

for i = lag
	sum = 0;
	count = 0;
	for j = 1:L-i
		sum = sum + p(j)*p(j+i);
		count = count + 1;
	end
	auto_correlation(L+i) = auto_correlation(L-i) = sum/count;
end

L = length(auto_correlation);
S = abs(fftshift(fft(auto_correlation))/L);

dt = t(2)-t(1);
dw = (2*pi)/(dt*L);
w = dw*(-L/2:L/2-1);

plot(w, 2*pi*S);
xlabel('w - angular frequency');
ylabel('PSDF');
