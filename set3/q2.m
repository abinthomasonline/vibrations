load elcentro.mat

m = 5000;
k_bu = 3000;
si = 0.02;

K = [2*k_bu -k_bu 0 0 0;
	-k_bu 2*k_bu -k_bu 0 0;
	0 -k_bu 2*k_bu -k_bu 0;
	0 0 -k_bu 2*k_bu -k_bu;
	0 0 0 -k_bu k_bu];
M = eye(5)*m;

[phi, w_sq] = eig(K, M);

q = zeros(5, 1);
dq = zeros(5, 1);
ddq = zeros(5, 1); 

for j=1:5
	wn = sqrt(w_sq(j, j));
	k = w_sq(j, j)*m;
	c = 2*m*wn*si;
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
	q(j) = max(x);
	dq(j) = wn*q(j);
	ddq(j) = wn*dq(j);
end


peak_resp = phi*q
peak_velo = phi*dq
peak_acce = phi*ddq
