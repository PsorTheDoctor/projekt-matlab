% Projekt 2. MATLAB
% Adam Wolkowycki

clear all
clc
close all

% zad. 1
plik = fopen('d310.txt');          % wczytywanie pliku
mat = fscanf(plik, '%f', [2 inf]); % utworzenie macierzy z pliku
fclose(plik);                      % zamkniecie pliku

x = mat(1, :); % zapis pierwszej kolumny do wek x
y = mat(2, :); % zapis drugiej kolumny do wek y

% zad. 2
% aproksymacja wielomianowa
st = 6;                  % stopien wielomianu aprox
wsp = polyfit(x, y, st); % wektor wspolczynnikow wielomianu
war = polyval(wsp, x);   % wektor wartosci wielomianu 
err = y - war;           % blad aproksymacji
err_max = max(abs(err)); % max blad aproksymacji

x_pocz = x(1);                         % poczatek dziedziny
x_kon = x(1505);                       % koniec dziedziny

% wielomian aproksymacji
wiel = @(x) wsp(1)*x.^6 + wsp(2)*x.^5 + wsp(3)*x.^4 + wsp(4)*x.^3 + wsp(5)*x.^2 + wsp(6)*x + wsp(7);

% calka za pomoca funkcji integral
calka = integral(wiel, x_pocz, x_kon); 

% calka metoda prostokatow
n = 10;                                % ilosc przedzialow calkowania
szer = (x_kon - x_pocz) / n;           % szerokosc przedzialu
x_calk = x_pocz:szer:x_kon;            % przedzialy
y_calk = wiel(x_calk);                 % wartosc calki w przedzialach

%hold on
%stem(x_calk, y_calk)
%stairs(x_calk, y_calk)
%hold off
suma = 0;
N = length(x_pocz:szer:x_kon);
for k = 1:N-1 
    suma = suma + szer*y_calk(k);
end 
calka_pros = suma;

% calka metoda trapezow
suma = 0;
while(x_pocz < x_kon)
   suma = suma + (szer./2).*(wiel(x_pocz)+wiel(x_pocz+szer));
   x_trapez = [x_pocz x_pocz+szer x_pocz+szer x_pocz];
   y_trapez = [0 0 wiel(x_pocz+szer) wiel(x_pocz)];
   % patch(x_trapez, y_trapez, '-r')
   % drawnow
   x_pocz = x_pocz + szer; 
end
calka_trap = suma;

% porownanie metod calkowania
err_pros = abs(calka - calka_pros); % blad metody prostokatow
err_trap = abs(calka - calka_trap); % blad metody trapezow

% zad. 3
avg = mean(y);             % srednia
odch_ser = std(y);         % odchylenie standardowe serii
odch_avg = avg / (N-1);    % odchylenie standardowe sredniej
niepewnosc = odch_ser / N; % niepewnosc

% zad. 4a
t_pocz = 0; % czas poczatkowy
dt = 0.01;  % krok czasowy
t_kon = 10; % czas koncowy
x01 = 0;    
x02 = 4;
x0 = [x01 x02];
% rownanie rozniczkowe za pomoca funkcji ode45
[t, xa] = ode45('zad_4a', t_pocz:dt:t_kon, x0);

% wykres rownania drgan mech
figure(1);
plot(t, xa(:,1), 'b-');
hold on;
plot(t, xa(:,2), 'r-');
xlabel('Czas [s]');
ylabel('Amplituda');
title('Rownanie drgan mechanicznych');
grid on;
legend('Odpowiedz uk³adu', 'Sygnal wejsciowy');

% zad. 4b
t_pocz = 0; % czas poczatkowy
dt = 0.01;  % krok czasowy
t_kon = 10; % czas koncowy
x01 = 1;
x02 = 0;
x0 = [x01 x02];
% rownanie rozniczkowe za pomoca funkcji ode45
[t, xb] = ode45('zad_4b', t_pocz:dt:t_kon, x0);

% wykres rownania ruchu drgajacego tlumionego
figure(2);
plot(t, xb(:,1), 'b-'); 
hold on;
plot(t, xb(:,2), 'g-');
title('Rownanie ruchu drgajacego tlumionego');
xlabel('Czas [s]');
ylabel('Amplituda');
grid on;
legend('Odpowiedz ukladu', 'Sygnal wejsciowy');
