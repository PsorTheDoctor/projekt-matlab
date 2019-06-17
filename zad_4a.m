function dy = zad_4a(t, x)
global n k ft;

m = 42;
c = 41;
alfa = 21;
A = 2;
omega = 20;

n = alfa / m;
k = sqrt(c / m);
ft = A * sin(omega * t);
dy = [x(2); ((-2*n)*x(2) - k*x(1) + ft)];
