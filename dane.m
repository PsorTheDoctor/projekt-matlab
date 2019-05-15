% Projekt MATLAB
% Adam Wolkowycki

clear all
clc
close all

% zad 2
load('d310.txt');        % wczytywanie z pliku
x = d310(:, 1);          % zapis pierwszej kolumny do wek x
y = d310(:, 2);          % zapis drugiej kolumny do wek y

% zad 3
st = 6;                  % stopien wielomianu aprox
wsp = polyfit(x, y, st); % wektor wspolczynnikow wielomianu
war = polyval(wsp, x);   % wektor wartosci wielomianu 
err = y - war;           % blad aproksymacji
err_max = max(abs(err)); % max blad aproksymacji

% zad 4
m_zer = roots(wsp);      % miejsca zerowe wielomianu

% zad 5
x_pocz = x(1);                        % poczatek dziedziny
x_kon = x(1505);                      % koniec dziedziny
x_interp = x_pocz:x_kon;              % argumenty wezlow interp
y_interp = interp1(x, war, x_interp); % wartosci interp
plot(x, y, x_interp, y_interp)        % wykres

% zad 6
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
