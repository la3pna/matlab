% Leeson simulator for standard Hartley/Pierce/Collpits (LC resonator)
% Gives double sideband? 3dB too high

f0 = 14000000; % oscillator frequency
Q = 100; % loaded Q
t = 300; % temp kelvin 
f = 10 ; % noise factor (not dB)
Vp = 4 ; % peak voltage across resonator
c = 100*10^-12; % resonator total capacitance
 
k = 1.3806*10^-23; %boltzmann constant
Fm = logspace(-1,5,500);
%Fm = 10000


Ps = (pi*f0*c*Vp^2)/Q;
NCR = ((k*t*f)/(2*Ps)).*((f0./(2.*Q.*Fm)).^2);
L = 10*log10(NCR)
semilogx(Fm,L);
grid on;