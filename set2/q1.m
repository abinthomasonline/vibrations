k = 400;
m = 100;
zetam = [0.02, 0.05, 0.1]; %damping ratio matrix [1x3]
wn = sqrt(k/m); %natural frequency
load elcentro.mat %load exciting force data (file should be in the same folder)

hold on; %to plot 3 responses on single graph

for zeta=zetam
	%newmark's beta method
	c = 2*m*wn*zeta; %damping coefficient
	ga = 0.5; %gamma
	be = 0.25; %beta
	dt = t(2)-t(1); %time interval
	f = 1/dt;
        w = -f/2:f/length(p):f/2-f/length(p); %frequency axis
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
        Su = abs(fft(x)).^2; %square of discrete fourier transform of p
        plot(2*pi*w, Su); %plot
end

hold off;
