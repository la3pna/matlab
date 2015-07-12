%program for theoretical estimation of intermodulation products in time
%domain and frequency domain.

a = 1;
n = 1:1:12;
t = (1:0.01:10000)*10^-6;
fa = 470;
fb = 1230;

amp = a*sin(2*pi*fa*t)+a*sin(2*pi*fb*t);
for k = 1:12
    amp = amp + (a*sin(2*pi*(k*fa*t)));
        
end
for k = 1:12
    amp = amp + (a*sin(2*pi*(k*fb*t)));
        
end

plot(t,amp)
hold on
figure(2)
fff = fft(amp,9991)
plot (20*log10((abs(fff))));

figure(3);
lfft=999999; % FFT size
yf=fft(amp,lfft);
semilogx((0:lfft-1)/lfft,abs(yf))
figure(4)
plot((0:lfft-1)/lfft,abs(yf))