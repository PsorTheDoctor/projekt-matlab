function dy = zad_4b(t, x)
global beta;

m = 6;
f = 4;
k = 0.5;

omega_pow2 = k / m;
beta = f /(2 * m);
dy = [x(2); ((-2*beta)*x(2) - omega_pow2*x(1))];
