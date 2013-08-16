%program for modelling of crystals.
%A = parallellfreq
%b= seriefreq

s = sortrows(xtal_freq,2)
cs=0.0000000000251;
l=1;
c0=c0.*0.000000000001 %gjør om til F
f = a;
%df = a-b;
c = (2.*(cs+c0))
ch = ((a-b)./a);
cm= c.*ch
w = 2*pi*f;
Lm = l./(w.^2.*cm);