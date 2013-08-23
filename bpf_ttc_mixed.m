function [Ce,Cte,Ctm,Cm,Ln] = bpf_ttc_mixed(Fm,Ln,Qu,B,R0)
% Calculates tripple tuned, mixed for filters.
%based on routine by Wes Hayward W7ZOI.
%Uses improved method of calculating Ctm, Cte, values differ a bit from
%TTC.exe. 

k = 0.7071; % k value for butterworth filter n = 3.
q = 1.0; % q value for butterworth filter n = 3.

w = 2 * pi * Fm * 10^6; %omega
L = Ln*10^-9; %Inductance in H.
Qf = Fm/B; % Q factor needed
Q0 = Qu/Qf; % normalized Q
C0 = 1/(w^2*L) % C0 capacitance

Qe = ((q*Qf)^-1 - (Qu)^-1)^-1; % Qe value the difficult way
K = k/Qf; % Denormalized coupling coefficient
Rs = w*(L/Qe);
Ce = sqrt((R0-Rs)/(Rs*w^2*R0^2));
%Cm = C0*k; % This gives the wrong value of Cm, need to get to that...

% C, CC, CCC is intermidiate values used in the calculations.
C = ((Ce^2*w^2*R0^2)+1)/(Ce*w^2*R0^2); % Series equiv. cap at termin. 
CC=((1/w)*(w*L-(1/w*C)))/(Rs^2+(w*L-1/(w*C))^2); % CC is cap at end for coupling coeff. 
CCC = sqrt(CC*C0); % Geometric average of C0 and CC

%then we can calculate the end coupling values 
Cm = (CCC*K); % Coupling capacitor
Cte = ((1/C0 - 1/C)^-1 - Cm); % Capacitor Cte (end resonator trimmer)
Ctm = (C0 - 2*Cm);  % Capacitor Ctm(center resonator trimmer)

%Lets get the values in pF:
Ce = Ce*10^12;
Cm = Cm*10^12;
Cte = Cte*10^12;
Ctm = Ctm*10^12;