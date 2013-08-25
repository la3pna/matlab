function [Cm, Lm] = xtal_par(Fp,Fs,C0)
%Calculates the motional parameters of crystal measured with the G3UUR
%method.
%Usage: xtal_par(Fp, Fs, C0); returns Cm, Lm.
%Fp = Paralell frequency ( switch open ) in Hz
%Fs = Series frequency ( switch closed ) in Hz
%C0 = Capacitance between plates (low frequency) in pF

%Here you need to define the Cs (capacitance in pf) of the jig paralel cap.
Cs = 33;

cs = Cs .* 10^-12; % takes Cs to F.
c0 = C0 .* 10^-12; %takes C0 to F.

df = Fp-Fs;
Cm = 2.*(cs+c0).*(df./Fs);
Lm = 1./((2*pi*Fs).^2 .*Cm);

%lets get Cm in pF.
Cm = Cm .* 10^12;