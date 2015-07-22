function [K] = k_factor(aiding, oposing)
%Script for calculating the K factor (coupling factor) of inductor.
%wind 2 inductors on the same core
%Measure inductance Aiding (in series) then
%Measure inductance Oposing (in paralell).
%ALL UNITS MUST BE THE SAME (nH, µH)!

a = aiding./oposing;
K = (a-1)./(a+1);