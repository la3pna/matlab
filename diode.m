%diode model
%Variables:
Is = 3*10^-15; %Saturation current in Amperes
T = 300; %ambivivaent temprature in Kelvin

%Constants and vectors:
q = 1.6*10^-19; %Electric charge
V = 0:0.001:0.859; % Voltage vector
k = 1.38*10^-23 ; %Boltzmann constant

I = Is*(exp((q*V)/(k*T))-1); %optimal diode model
%subplot (1,3,1)
figure(1)
plot (V, I,'linewidth',2)
grid on;
xlabel ('Voltage in V')
ylabel ('Current in A')
title('Optimal Diode model')

%subplot (1,3,2)
figure(2)
Rin = (26*10^-2)./I;
semilogy(V,Rin,'g','linewidth',2);
grid on;
xlabel ('Voltage in V')
ylabel ('Resistance in Ohm')
title('Diode resistance')

%subplot (1,3,3)
figure(3)
hold on
It = Is*exp((q*V)/(k*T));
plot (V, It,'r','linewidth',2)
xlabel ('Voltage in V')
ylabel ('Current in A')
title('Simplified Diode model')
grid on