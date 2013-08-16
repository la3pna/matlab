%calculates Xc over F. 
c = 100*10^-12;
a = 10^6 : 1000 : 10^7; %Frequency step and limits
s = 2*pi*a;

y= 1./(c*s);

semilogx (a,y);
title(Reactance of capacitor)
xlabel(Frequency Hz);
ylabel(Reactance Xc);
grid on;