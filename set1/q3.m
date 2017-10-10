k = 400;
m = 100;
zeta = 0.02; %damping ratio
F = 1; %magnitude of exciting force
wn = sqrt(k/m); %natural frequency
wd = [wn/2, wn, 2*wn]; %excitation angular frequency (matrix[1x3])
X_steady = F./sqrt((wn^2-wd.^2).^2+(2*wd*wn*zeta).^2); %max amplitude of steady response (matrix[1x3])
Theta_steady = atan((2*wd*wn*zeta)./(wn^2-wd.^2)); %phase angle of steady response (matrix[1x3])
Theta_transient = atan((-1*(wn*zeta+wd.*tan(Theta_steady)))./(wn*sqrt(1-zeta^2))); %max amplitude of transient response (matrix[1x3])
X_transient = -1*X_steady.*cos(Theta_steady)./cos(Theta_transient); %phase angle of transient response (matrix[1x3])
t = (0:0.01:100)'; %time (x-axis)
Xs = X_steady.*cos(t*wd.-Theta_steady); %steady state response (matrix[nx3])
Xt = exp(-1*wn*zeta*t).*(cos(wn*sqrt(1-zeta^2)*[t,t,t] + Theta_transient).*X_transient); %transient state response (matrix[nx3])
X = Xt + Xs; %total response (y-axis) (matrix[nx3])
plot(t,X); %Plot
