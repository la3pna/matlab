% j-fet simulations and calculations.
% from http://www.qrp.pops.net/fetbias.asp

Vp = -3.417 ; % volt (negative for N channel)
Idss = 30; % milliamperes
Id = 2 ;% selected bias point mA


V = Vp:0.01:0;

a = V/Vp;
I = Idss * (1-a).^2;

figure(1);
plot(V,I,'linewidth',2);
xlabel('Voltage Vg');
ylabel('I(v) Drain current mA');
title('J-FET biasing');
xkcdify(gca)
Ida = Id *10^-3;
Idssa = Idss *10^-3;

Rs = Vp/Ida*(sqrt(Ida/Idssa)-1)

[x,y] = min(abs(I-Id)); % creative approach to finding Vgs and its point in the vector
Vgs = V(y);

Gm = 2*(Idssa/Vp)*(1-(Vgs/Vp))

%plot Gm with different Vgs
Gma = 2.*(Idssa./Vp).*(1-(V./Vp));
figure(2);
plot(V,Gma,'linewidth',2);
xlabel('Voltage Vgs');
ylabel('Gm (Siemens)');
title('J-FET transconductance');
xkcdify(gca)
