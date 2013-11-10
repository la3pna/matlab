% Transfer function plot for an Nth order butterworth filter
% plots the responce from W=0 to W = 10

n = 2;

w = 0:0.01:10;

Gdb = 10* log10(sqrt(1./(1+w.^(2.*n))));
semilogx(w,Gdb);
title('Butterworth filter');
xlabel('Frequency (w)');
ylabel('Amplitude (dB)');