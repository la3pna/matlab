% definition on what vector to calculate K from
%Vector configured as L(aiding), L(opposing)
%x = ft3743  ;
%do the calculation
function [klist] = inductance_k(inductors)


for i = 1:(length(inductors))
    
a = inductors(i,1)/inductors(i,2);
k = (a-1)/(a+1);
Klistmod(i)=k ;
end
klist = Klistmod;
end