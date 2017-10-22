load elcentro.mat %load elcentro data

dp = 0.01; %interval in x-axis
x = min(p):dp:max(p); %x-axis
x(length(x)+1) = x(length(x)) + dp; %end point of x-axis
y = zeros(1, length(x)); %y-axis initialized with all zeros

for i=1:1:length(p)
	x_index = round((p(i)-min(p))/dp) + 1; % index to which p(i) belongs
	y(x_index) = y(x_index) + 1; % increment y(index)
end

y = y./trapz(x,y); %normalization 'trapz() does integration'

plot(x,y);
