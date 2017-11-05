load elcentro.mat

dp = 0.01;
x = min(p):dp:max(p);
x(length(x)+1) = x(length(x)) + dp;
count = zeros(1, length(x));

for i=1:1:length(p)
	index = round((p(i)-min(p))/dp) + 1;
	count(index) = count(index) + 1;
end

probability = count./(dp*sum(count));
plot(x,probability);
