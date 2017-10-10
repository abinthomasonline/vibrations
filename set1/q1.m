k = 400;
m = 100;
zeta = 0.02; %damping ratio
F = 1; %magnitude of exciting force
wd = 2*pi; %angular frequency of exciting force
wn = sqrt(k/m); %natural frequency
X_steady = F/sqrt((wn^2-wd^2)^2+(2*wd*wn*zeta)^2); %max amplitude of steady response
Theta_steady = atan((2*wd*wn*zeta)/(wn^2-wd^2)); %phase angle of steady response
Theta_transient = atan((-1*(wn*zeta+wd*tan(Theta_steady)))/(wn*sqrt(1-zeta^2))); %max amplitude of transient response
X_transient = -1*X_steady*cos(Theta_steady)/cos(Theta_transient); %phase angle of transient response 
t = 0:0.01:100; %time (x-axis)
Xs = X_steady*cos(wd*t-Theta_steady); %steady state response (y-axis)
Xt = exp(-1*wn*zeta*t).*X_transient.*cos(wn*sqrt(1-zeta^2)*t + Theta_transient); %transient state response (y-axis)
plot(t,Xt,t,Xs); %Plots
