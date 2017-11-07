clear all
load elcentro.mat

m = 100;
k = 400;
zeta = 0.02;
wn = sqrt(k/m);
c = 2*m*wn*zeta;
L = length(t);
dt = t(2)-t(1);
dw = (2*pi)/(dt*L);
w = dw*(-L/2:L/2-1);

% response using time history analysis
FFT_p = fftshift(fft(p));
H = 1./(-m*w.^2 + i*c*w + k);
FFT_u = H.*FFT_p;
U = ifft(fftshift(FFT_u));

% response using newmarks beta method
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

plot(t, U, t, x);
xlabel('t - time');
ylabel('u - response');
legend('time history', 'newmarks beta');

% PSDF using spectral analysis
y = fftshift(fft(p))/L;
S = y.*conj(y)./(2*dw);
S_u = S.*H.*conj(H);

% PSDF from newmarks beta method
FFT_x = fftshift(fft(x))/L;
S_x = FFT_x.*conj(FFT_x)./(2*dw);

figure;
plot(w, 2*S_u, w, 2*S_x);
xlabel('w - angular frequency');
ylabel('u - response');
legend('spectral analysis', 'newmarks beta');
