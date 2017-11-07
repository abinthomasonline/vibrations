m = 5000;
k = 3000;
wn = sqrt(k/m);
si = 0.02;
c = 2*si*wn*m;

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


modal_damping = phi'*C*phi
modal_mass = phi'*M*phi
modal_stiffness = phi'*K*phi
