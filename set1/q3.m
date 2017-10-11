k = 400;
m = 100;
zeta = 0.02; %damping ratio
F = 1; %magnitude of exciting force
wn = sqrt(k/m); %natural frequency
wdm = [wn/2, wn, 2*wn]; %excitation frequency matrix [1x3]
w0 = wn*sqrt(1-zeta^2); %angular frequency of transient state
t = 0:0.001:70;

hold on; %to plot 3 responses on single graph

for wd=wdm
	X_steady = F/(m*sqrt((wn^2-wd^2)^2+(2*wd*wn*zeta)^2)); %max amplitude of steady response matrix[1x3]
	Theta_steady = atan((-2*wd*wn*zeta)/(wn^2-wd^2)); %phase angle of steady response
	Xs = X_steady*cos(wd*t - Theta_steady); %steady state response

	X0 = 0.0003; % initial displacement
	U0 = 0; % initial velocity

	Theta_transient = atan((1-U0/X0)/w0); %phase angle of transient response
	X_transient = X0/cos(Theta_transient); %max amplitude of transient response
	Xt = exp(-1*wn*zeta*t).*(X_transient*cos(w0*t - Theta_transient)); %transient state response

	plot(t,Xt,t,Xs); %plot
end

hold off;
