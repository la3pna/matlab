n = 0:0.01:2;

y = 1 - heaviside(n-1) % LPF
%y =  heaviside(n-1) % HPF

plot(n,y,'linewidth', 2);
title('Ideal lowpass filter');
xlabel('Frequency (w)');
ylabel('Amplitude (dB)');
%xkcdify(gca)
grid on;