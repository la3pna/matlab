function [m, thd] = smith_ch_calc(Z0, Zl,col) 

% Draw appropriate chart
draw_smith_chart 

% Normalize given impedance
zl = Zl/Z0; 

% Calculate reflection, magnitude and angle
g = (zl - 1)/(zl + 1);
m = abs(g);
th = angle(g); 

% Plot appropriate point
polar(th, m, col) 

% Change radians to degrees
thd = th * 180/pi; 
