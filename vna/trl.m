function [Sx,GL]=trl(Sthru,Sopen,Sline,Sdut,freq);

% TRL performs a two-tier TRL calibration for a vector network analyser.
% The first calibration consist of a normal co-axial SOLT two-port calibration
% followed by measurements on the TRL calibration standards and the DUT. The 
% function then performs the second tier of the calibration by de-embedding the
% effect of the TRL test fixture from the DUT measurements using the measurements
% peformed on the TRL calibration standards.  
% 
% The function uses the following input parameters:
%
%    Sthru   Four colom matrix containing S-Parameters of the thru measurement on
%            TRL test fixture.
%    Sopen   Four colom matrix containing S-Parameters of the open measurement on
%            TRL test fixture.  Only S11 and S22 is of interest here and the S21 and
%            S12 data which will be in the noise floor of the VNA will be discarded.
%    Sline   Four colom matrix containing S-Parameters of the line measurement on
%            TRL test fixture.
%    Sdut    Four colom matrix containing S-Parameters of the DUT inserted into the
%            TRL test fixture.
%    f       Frequencies at which S-Parameters were measured in Hz.
%
% The coloms of the S-Parameter matrix represent [S11 S21 S12 S22].
%
% format: [Sx,GL]=trl(Sthru,Sopen,Sline,Sdut,freq)
%
% The output consists of the de-embedded device S-Parameters (Sx), and the propagation 
% constant (GL) of the line standard used in the TRL calibration.  The propagation constant
% can be used to calculate the characteristic impedance of the microstrip calibration 
% line.  Since microstrip is a dispersive transmission line, the characteristic impedance
% will vary as a function of frequency.  The measured S-Parameters will be normalised with
% respect to the actual characteristic impedance of the transmission line calibration
% standard.  By extracting this impedance, the S-Parameter data can be renormalised to 
% 50 Ohm.  
%
% See TRLPOST.M for some post processing functions that can be performed.
%
% Writer  : C. van Niekerk
% Version : 3.50
% Date    : 07/06/1995

% This program is based on the work in the presented in the following paper:
%
% [1]   G.F. Engen, C.A. Hoer, "Thru-Reflect-Line: An Improved Technique for
%       Calibrating the Dual Six-Port Automatic Network Analyser,"
%       IEEE Trans. MTT, Vol. 27,No. 12, December 1979, pp. 987-998


% Define the imaginary constant

i=sqrt(-1);     

% Convert the measured s-parameters of the DEVICE to one variable

S11d = Sdut(:,1);
S21d = Sdut(:,2);
S12d = Sdut(:,3);
S22d = Sdut(:,4);

% Convert the measured s-parameters of the REFLECT standerd to one variable

S11r = Sopen(:,1);
S22r = Sopen(:,4);

% Convert the measured s-parameters of the THRU standerd to one variable

S11t = Sthru(:,1);
S21t = Sthru(:,2);
S12t = Sthru(:,3);
S22t = Sthru(:,4);

% Convert the measured s-parameters of the LINE standerd to one variable

S11l = Sline(:,1);
S21l = Sline(:,2);
S12l = Sline(:,3);
S22l = Sline(:,4);

% Compute the wave cascading matrix for the thru standerd

R11t = -(S11t.*S22t - S12t.*S21t)./S21t;
R12t =  S11t./S21t;
R21t = -S22t./S21t;
R22t =  1 ./ S21t;

% Compute the wave cascading matrix for the line standerd

R11l = -(S11l.*S22l - S12l.*S21l)./S21l;
R12l =  S11l./S21l;
R21l = -S22l./S21l;
R22l =  1 ./ S21l;

% Compute the wave cascading matrix for the device standerd

R11m = -(S11d.*S22d - S12d.*S21d)./S21d;
R12m =  S11d./S21d;
R21m = -S22d./S21d;
R22m =  1 ./ S21d;

% Calculate the two possible virtual error networks for port A
% and port B using the s-parameters of the thru and line standerds

% Determine the number of frequency points

nfreq=length(freq);

for n = 1:nfreq

  Rt = [ R11t(n) R12t(n) ; R21t(n) R22t(n) ];
  Rl = [ R11l(n) R12l(n) ; R21l(n) R22l(n) ];
  T  = Rl*inv(Rt);

% Solve a set of quadratic equations to get the values of r11a/r21a
% and r12a/r22a

  A =  T(2,1);
  B =  T(2,2) - T(1,1);
  C = -T(1,2);

  K1 = (-B + sqrt((B^2)-4*A*C))/(2*A);
  K2 = (-B - sqrt((B^2)-4*A*C))/(2*A);

% Choose between the two possible roots to get the right values for
% b and c/a

  if abs(K1)<abs(K2)
    b  = K1;
    ca = 1/K2;
  end;

  if abs(K2)<abs(K1)
    b  = K2;
    ca = 1/K1;
  end;

% Calculates the propogation constant of the LINE standerd.

  GL(n) = -log(T(1,1)+T(1,2)*ca);

% Calculates "a"

  w1 = S11r(n);
  w2 = S22r(n);

  g =  1/S21t(n);
  d = -(S11t(n)*S22t(n) - S12t(n)*S21t(n));
  e =  S11t(n);
  f = -S22t(n);

  gamma     = (f-d*ca)/(1-e*ca);
  beta_alfa = (e-b)/(d-b*f);

  a = sqrt(((w1-b)*(1+w2*beta_alfa)*(d-b*f))/((w2+gamma)*(1-w1*ca)*(1-e*ca)));

% Calculates the reflection coeffisients at each port to determine the correct
% sign that should be assigned to a

  R1a = (w1-b)/(a-w1*a*ca);
  R1b = (w1-b)/(w1*a*ca-a);

% An open is used for the reflection measurement.  Use this information to
% chose the sign of a 

  if abs(angle(R1a)*180/pi)<90
    a = a;
    as(n) = a;
    c = ca*a;
  end;

  if abs(angle(R1b)*180/pi)<90
    a = -a;
    as(n) = a;
    c = ca*a;
  end;

  R1(n) = (w1-b)/(a-c*w1);

  alfa = (d-b*f)/(a*(1-e*ca));
  beta = beta_alfa*alfa;

  r22p22 = R11t(n)/(a*alfa + b*gamma);

  IRa = [ 1 -b ; -c a ];
  IRb = [ 1 -beta ; -gamma alfa ];

  Rm  = [ R11m(n) R12m(n) ; R21m(n) R22m(n) ];

  Rx = 1/(r22p22*(alfa-gamma*beta)*(a-b*c))*IRa*Rm*IRb;

  S11x(n) =  Rx(1,2)/Rx(2,2);
  S12x(n) =  Rx(1,1) - Rx(1,2)*Rx(2,1)/Rx(2,2);
  S21x(n) =  1/Rx(2,2);
  S22x(n) = -Rx(2,1)/Rx(2,2);

end;

Sx=[S11x.' S21x.' S12x.' S22x.'];

