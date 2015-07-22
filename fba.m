

a =  (((beta + 1)^2 *Re^2) - (2 * beta * Rf * (beta + 1) * Re)) + beta^2 * Rf^2
b = (((1 + beta) * Re * Rsource) * Rf) + (Rload + Rsource + (beta * Rsource) + (beta * Rload)) * (Re + (beta * Rsource * Rload)) + (Rload * Rsource)

gain = 10*log10(4.0*Rload*Rsource*(a/(b*b)))

