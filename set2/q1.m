load elcentro.mat
m = 100; k_vector = 0:4:1600;

hold on;

for zeta = [0.02, 0.05, 0.1]
	for j=1:1:401
		k = k_vector(j);
		wn = sqrt(k/m);
		c = 2*m*wn*zeta;
		ga = 0.5;
		be = 0.25;
		dt = t(2)-t(1);
		C1 = m/(be*dt) + (c*ga)/be;
		C2 = m/(2*be) + (c*dt)*(ga/(2*be)-1);
		kc = k + (c*ga)/(be*dt) + m/(be*dt*dt);
		x(1)=0;
		u(1)=0;
		a(1)=(p(1)-k*x(1)-c*u(1))/m;
		for i=1:1:(length(t)-1)
			dp=p(i+1)-p(i);
			dx=(dp+C1*u(i)+C2*a(i))/kc;
			du=(dx*ga)/(be*dt) - (u(i)*ga)/be - a(i)*dt*(ga/(2*be)-1);
			da=dx/(be*dt*dt) - u(i)/(be*dt) - a(i)/(2*be);
			x(i+1)=x(i)+dx;
			u(i+1)=u(i)+du;
			a(i+1)=a(i)+da;
		end
		resp_spectrum(j) = max(x);
	end
	plot(sqrt(k_vector./m), resp_spectrum);
end
xlabel('wn - natural frequency');
ylabel('maximum response');
legend('0.02', '0.05', '0.1');
