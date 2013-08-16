% use file -> import data to import wave file.
% gives data and sample matrixes.
% sample matrix must be renamed to Fs
%
%data=xx
Fs=fs;
%L=1000;
L=length(data)
NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(data,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

%plot time
subplot (3,1,1);
plot (data); grid on;
title('Single-Sided Amplitude over time of  y(t)')
xlabel('time ms.')
ylabel('|Y(f)|')

% Plot single-sided amplitude spectrum.
subplot(3,1,2);
plot(f,2*abs(Y(1:NFFT/2+1))); grid on;
title('Single-Sided Amplitude Spectrum of y(t)')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


%soundsc (data, Fs)
subplot(3,1,3);

spectrogram (data, fs);