function [ret] = butler(freq)

f = freq*10^6;
w = 2*pi*f;

c1calc = 1/(w.*159); %capacitor to collector
C1 = c1calc .* 10^12;
 c2calc = 1/(w.*40); % capacitor to ground 
 C2 = c2calc .* 10^12;
 l1calc = 100./w; % inductor to supply
 L1 = l1calc .* 10^6;
 ccpl = 1/(w.*320);
Ccpl = ccpl.*10^12;
a =1/(1/c1calc + 1/c2calc) ;
ctune = (w.^2.*l1calc).^-1 - a;
Ctune = ctune.*10.^12;
ret = [freq, C1, C2, Ccpl, Ctune, L1];

