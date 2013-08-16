function v=cohn(n,F,B,Lm)
% function calculates k and q values for cohn filter
%n = 10; % change to no of crystals.
%na = 1:1:n;
k = 0.5.*exp(log(2)./n)
q = 1./k
%v = [k,q]
jk = 1:1:n+1;
cjk(jk) = 1/(4*k*B*pi^2*F*Lm);
cjk = cjk.*10^12;
Re = (2*pi*B*Lm)/q;
v = [cjk, Re];