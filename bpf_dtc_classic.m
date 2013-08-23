%Filter sidebar EMRFD p.3.14
function [C12p,Ctp,Cep,C0p]=bpf_dtc_classic(Fm,Lu,Bm,Qu,R0,k,q)
%[c12,ctp,cep,c0p]=bpf_dtc_classic(7.1,1.5,0.2,200,50,0.707,1.414)

%constants
f = Fm * 10^6; %convert from MHz to Hz
w = 2* pi* f ;
l = Lu/10^6; %convert L from µH to H
b = Bm*10^6;

if k == 0 % takes care of the definition of k for butterworth
    k = 0.707;
end

if q == 0; % takes care of the definition of q for butterworth
    q = 1.414;
end

%calculations
c0 = 1/(w^2 * l);
c12 = c0 * ((k*b)/f) ;
Qe = (q * f * Qu)/ ((b*Qu)-(q*f));
ce = (1/w)* (1/sqrt(R0*Qe*w*l-R0^2));
ct =  c0 - ce - c12 ;

%convert to pF
C0p = c0*10^12;
C12p = c12*10^12 ; 
Ctp = ct*10^12 ;
Cep = ce*10^12 ;