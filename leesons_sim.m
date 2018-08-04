% This is a basic Leeson phase noise simulator

f0 = 10000000; % oscillator frequency
Ql = 25; % loaded Q
ps = 0.01; % oscillator power W; 
t = 300; % temp kelvin 
f = 100 ; % noise factor 
 
k = 1.3806*10^-23; %boltzmann constant
fofs = logspace(-1,5,500);



L = 10.*log10(1/2.*(((f0./(2.*Ql.*fofs)).^2).*((fc./fofs)+1)).*((f*k*300)/ps))
semilogx(fofs,L);
grid on;