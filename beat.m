function [xx, tt] = beat(A, B, fc, delf, fsamp, dur)
%BEAT compute samples of the sum of two cosine waves
% usage:
% [xx, tt] = beat(A, B, fc, delf, fsamp, dur)
%
% A = amplitude of lower frequency cosine
% B = amplitude of higher frequency cosine
% fc = center frequency
% delf = frequency difference
% fsamp = sampling rate
% dur = total time duration in seconds
% xx = output vector of samples
%--Second Output:
% tt = time vector corresponding to xx
tt = 0:(1/fsamp):dur;
f1 = fc-delf;
f2 = fc+delf;
xt = syn_sin2([f1,f2],[A,B],fsamp,dur);
xx = real(xt);
 
%plot (tt,xx); grid on; %fjern % for plot av signal
soundsc( xx, fsamp );
% specgram(xx,16,fsamp); %fjern % for spektogram

