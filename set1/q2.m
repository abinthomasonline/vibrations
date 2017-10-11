beta = (0:0.01:4)'; %w/wn (x-axis)
zeta = [0.01, 0.02, 0.05, 0.7]; %damping ratio
DAF = 1./sqrt((1-beta.^2).^2*ones(1,length(zeta)) + (2*beta*zeta).^2); %dynamic amplification factor (y-axis)
plot(beta, DAF); %plot
