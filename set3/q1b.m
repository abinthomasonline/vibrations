load elcentro.mat

m = 5000;
k = 3000;
wn = sqrt(k/m);
si = 0.02;
c = 2*si*wn*m;
dof = 5;

K = [2*k -k 0 0 0;
	-k 2*k -k 0 0;
	0 -k 2*k -k 0;
	0 0 -k 2*k -k;
	0 0 0 -k k];
M = eye(5)*m;
C = [2*c -c 0 0 0;
	-c 2*c -c 0 0;
	0 -c 2*c -c 0;
	0 0 -c 2*c -c;
	0 0 0 -c c];

[phi, w_sq] = eig(K, M);

modal_damping = phi'*C*phi;
modal_mass = phi'*M*phi;
modal_stiffness = phi'*K*phi;

ga = 0.5;
be = 0.25;
dt = t(2)-t(1);
C1 = modal_mass/(be*dt) + (modal_damping*ga)/be;
C2 = modal_mass/(2*be) + (modal_damping*dt)*(ga/(2*be)-1);
kc = modal_stiffness + (modal_damping*ga)/(be*dt) + modal_mass/(be*dt*dt);

x = zeros(dof, length(t));
u = zeros(dof, length(t));
a = zeros(dof, length(t));
response = zeros(dof, length(t));
P = [p; zeros(dof-1, length(t))];

x(:, 1)=0;
u(:, 1)=0;
response(:, 1) = phi*u(:, 1);
a(:, 1)=modal_mass\(P(:, 1)-modal_stiffness*x(:, 1)-modal_damping*u(:, 1));

for i=1:1:(length(t)-1)
	dp=P(:, i+1)-P(:, i);
	dx=kc\(dp+C1*u(:, i)+C2*a(:, i));
	du=(dx*ga)/(be*dt) - (u(:, i)*ga)/be - a(:, i)*dt*(ga/(2*be)-1);
	da=dx/(be*dt*dt) - u(:, i)/(be*dt) - a(:, i)/(2*be);
	x(:, i+1)=x(:, i)+dx;
	u(:, i+1)=u(:, i)+du;
	a(:, i+1)=a(:, i)+da;
	response(:, i+1)=phi*x(:, i+1);
end

plot(t, response);
xlabel('t - time');
ylabel('u - response');
legend('m1', 'm2', 'm3', 'm4', 'm5');
