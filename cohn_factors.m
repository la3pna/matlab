function v=cohn_factors(n)
% function calculates k and q values for cohn filter
%n = 10; % change to no of crystals.
%na = 1:1:n;
k = 0.5.*exp(log(2)./n);
q = 1./k;
v = [k,q];