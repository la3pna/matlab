% Transfer function plot for an Nth order butterworth filter
% plots the responce from W=0 to W = 10

w = 0:0.1:10;

col=['b','g','r','c','m','y','k','b','g','r']
for n = 1:10;



Gdb = 20* log10(sqrt(1./(1+w.^(2.*n))));
semilogx(w,Gdb,col(n),'linewidth',3);
hold on;
end
title('Butterworth filter');
xlabel('Frequency (w)');
ylabel('Amplitude (dB)');
%xkcdify(gca)
grid on;
