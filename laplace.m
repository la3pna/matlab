%script for å plotte størrelsen av
%Laplacetransformer

[X,Y] = meshgrid(-2:.05:2, -2:.05:2);
s=X+j*Y;
%legg inn uttrykket for F(s) som vist
%F = log(abs(F(s)))
% her er F(s)=s./(s.^2+s+1)+1./s+1./(s-.5).^2
Z = log(abs(s./(s.^2+s+1)+1./s+1./(s-.5).^2));                                        
surf(X,Y,Z)