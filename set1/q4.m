k = 400;
m = 100;
zeta = 0.02; %damping ratio
wn = sqrt(k/m); %natural frequency
c = 2*m*wn*zeta; %damping coefficient
load elcentro.mat %load exciting force data

%{
%newmark's beta method
ga = 0.5; %gamma
be = 0.25; %beta
dt = t(2)-t(1); %time interval
C1 = m/(be*dt) + (c*ga)/be; %coefficient of velocity in incrementation equation
C2 = m/(2*be) + (c*dt)*(ga/(2*be)-1); %coefficient of acceleration in incrementation equation
kc = k + (c*ga)/(be*dt) + m/(be*dt*dt); %coefficient of change in displacement in incrementation equation
x(1)=0; %initial displacement
u(1)=0; %initial velocity
a(1)=(p(1)-k*x(1)-c*u(1))/m; %initial acceleration
for i=1:1:(length(t)-1)
	dp=p(i+1)-p(i); %change in excitation
	dx=(dp+C1*u(i)+C2*a(i))/kc; %change in displacement
	du=(dx*ga)/(be*dt) - (u(i)*ga)/be - a(i)*dt*(ga/(2*be)-1); %change in velocity
	da=dx/(be*dt*dt) - u(i)/(be*dt) - a(i)/(2*be); %change in acceleration
	x(i+1)=x(i)+dx; %increment displacement
	u(i+1)=u(i)+du; %increment velocity
	a(i+1)=a(i)+da; %increment acceleration
end
%plot(t,x); %plot
%}

%duhamel's integral numerical evaluation
w0 = wn*sqrt(1-zeta*zeta); %frequency of vibration with damping
h = (exp(-1*zeta*wn*t).*sin(w0*t))./(m*w0); %unit amplitude response
dt = t(2)-t(1); %time interval
X(1) = 0; %initial condition
for i=2:1:length(t)
	X(i)=0;
	for j=1:1:(i-1)	%loop for integration
		X(i)=X(i)+p(j)*h(i-j)*dt;
	end
end
plot(t,X); %plot
