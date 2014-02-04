function [freq, s21, db]=sparameter(data)
% function to fix S-parameters to correct form. 
% ------------------------------------------------------------
% MATLAB example on how to import and plot an S-parameter data
% file obtained with a HP8753B Network Analyzer and Agilent VEE.
%
% NB: This script assumes that format of the data is frequencies
% in Hz and S-parameters in real and imaginary parts. As example
% this would be stated as # Hz S RI R 50 in the .s2p file.
%
% NB: Before running this script, open the .s2p file with a
% text editor and remove all lines starting with ! or # so that
% the file only contains data and save it.
% ------------------------------------------------------------

%close all;
%clear all;
%clc;


freq = data(:,1);
s21_real = data(:,2);
s21_imag = data(:,3);
s21 = complex(s21_real,s21_imag);
db = 20*log10(abs(s21));



%figure(1);
%plot(freq, 20*log10(abs(s21)));
%title('S_{21}');
%xlabel('Frequency [Hz]');
%ylabel('dB');

