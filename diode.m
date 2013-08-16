%diode model
%Variables:
Is = 3*10^-15; %Saturation current in Amperes
T = 300; %ambivivaent temprature in Kelvin

%Constants and vectors:
q = 1.6*10^-19; %Electric charge
V = 0:0.001:0.859; % Voltage vector
k = 1.38*10^-23 ; %Boltzmann constant

I = Is*(exp((q*V)/(k*T))-1); %optimal diode model
subplot (1,3,1)
plot (V, I)
grid on;
xlabel ('Voltage in V')
ylabel ('Current in A')
title('Optimal Diode model')

subplot (1,3,2)
Rin = (26*10^-12)./I;
plot (V,Rin,'g');
xlabel ('Voltage in V')
ylabel ('Resistance in Ohm')
title('Diode resistance')

subplot (1,3,3)
It = Is*exp((q*V)/(k*T));
plot (V, It)
xlabel ('Voltage in V')
ylabel ('Current in A')
title('Simplified Diode model')
grid on