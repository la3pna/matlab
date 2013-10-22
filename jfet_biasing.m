% j-fet simulations and calculations.
% from http://www.qrp.pops.net/fetbias.asp

Vp = -2.8 ; % volt (negative for N channel)
Idss = 11; % milliamperes
Id = 5 ;% selected bias point mA


V = Vp:0.01:0;

a = V/Vp;
I = Idss * (1-a).^2;

plot(V,I);
xlabel('Voltage Vg');
ylabel('I(v) Drain current mA');
title('J-FET biasing');

Ida = Id *10^-3;
Idssa = Idss *10^-3;

Rs = Vp/Ida*(sqrt(Ida/Idssa)-1)

[x,y] = min(abs(I-Id)); % creative approach to finding Vgs and its point in the vector
Vgs = V(y);

Gm = 2*(Idssa/Vp)*(1-(Vgs/Vp))


