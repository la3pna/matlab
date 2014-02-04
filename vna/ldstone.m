function [S,freq]=ldstone(FileName,Fmin,Fmax,dsp);

% LDSTONE(...) loads the measured s-parameter data from a text file with Touchstone
% format.  FileName is a text variable containing the full path and filename of 
% the file to be loaded, Fmin is the minimum frequency of measurement points
% that must be considered and Fmax is the maximum frequency for which data should
% be loaded from file.  Any s-parameters measured at frequencies below Fmin and
% above Fmax will not be returned to the user.  Fmin and Fmax are optional parameters
% if they are neglected from the parameter list, then values of Fmin = 1 Hz and 
% Fmax = 500 GHz will be set as the default values.
%
% format: [S,freq]=ldstone(FileName,Fmin,Fmax,dsp)
%
% The matrix S containts the loaded s-parameters in complex format.  Fhe first
% colom is S11, the second S21, the third S12 and the last S22.  The variable 
% freq contains the measurement frequencies in Hz.
%

% Author: Cornell van Niekerk
% Date  : 2001/01/17
%
% (c) Cornell van Niekerk
%     Dept. Electrical and Electronic Engineering
%     University of Stellenbosch
%     Stellenbosch
%     South Africa

% Set the default values of the optional parameters

if (nargin < 4)  dsp  = 0;      end;
if (nargin < 3), Fmax = +500E9; end;
if (nargin < 2), Fmin = -500E9; end;

% Read the header of the Touchstone file by checking for comments
% and the unit identifier line.  If the unit ID line is read, 
% scan the contents to determine the format in which the two port
% parameters are stored, as well as the unit of the measured
% frequencies.

nl = 1;
FUnit = 0;
fid = fopen(FileName);
while nl == 1,
    
    % Read the current line in the file as a text string and remove any
    % trailing blanks in the line
    
    line = deblank(fgetl(fid));
    nl = 0;
    
    % check the length of the line to see if it contains anything.  If the
    % line has no length, then treat it as a blank line and skip it by
    % marking it as a comment line
    
    if (length(line) == 0), 
        nl = 1;,
        line='!';
    end;
    
    % if a valid line has been read, then check the first character in the
    % line to see if it is a comment line or if the line contains the #
    % marker that indicates the format of the numeric data to come
    
    if strcmp(line(1),'!') == 1, nl = 1;,end;
    if strcmp(line(1),'#') == 1
        nl = 1;
        if findstr(upper(line),'HZ')  > 0, FUnit = 1E0;, end;
        if findstr(upper(line),'GHZ') > 0, FUnit = 1E9;, end;
        
        if findstr(upper(line),'MHZ') > 0, FUnit = 1E6;, end;
        if findstr(upper(line),'KHZ') > 0, FUnit = 1E3;, end;
        
        if findstr(upper(line),'MA') > 0, DatFor=1;, end;
        if findstr(upper(line),'RI') > 0, DatFor=2;, end;
        
    end;
end;

% Load the two-port data and copy it into Matrix S

i=sqrt(-1);
c = 0;

while 1
    
    [vector] = sscanf(line,'%f');
    
    if  ( (vector(1)*FUnit > Fmin) & (vector(1)*FUnit < Fmax)),
    
        % If the data line read from the file contains 3 coloms, then the
        % file contains 1-port data
        
        if (length(vector) == 3),
            c = c + 1;
            freq(c,1)=vector(1)*FUnit;
            if DatFor == 1
                S(c,1)=vector(2)*exp(i*vector(3)/180*pi);
            end;
            if DatFor == 2
                S(c,1)=vector(2) + i*vector(3);
            end;
        end;
        
        % If the data line read from the file contains 9 coloms, then the
        % file contains 2-port data
        
        if (length(vector) == 9),
            c = c + 1;
            freq(c,1)=vector(1)*FUnit;
            if DatFor == 1
                S(c,1)=vector(2)*exp(i*vector(3)/180*pi);
                S(c,2)=vector(4)*exp(i*vector(5)/180*pi);
                S(c,3)=vector(6)*exp(i*vector(7)/180*pi);
                S(c,4)=vector(8)*exp(i*vector(9)/180*pi);
            end;
            if DatFor == 2
                S(c,1)=vector(2) + i*vector(3);
                S(c,2)=vector(4) + i*vector(5);
                S(c,3)=vector(6) + i*vector(7);
                S(c,4)=vector(8) + i*vector(9);
            end;
        end;
        
    end;
    
    line = fgetl(fid);
    if ~isstr(line), break, end
    
end;


% close the file

fclose(fid);

% if requested, the data loaded from file is displayed graphically

if (dsp > 0),
    
    subplot(2,2,1)
    smith(S(:,1))
    
    subplot(2,2,2)
    polar(angle(S(:,3)),abs(S(:,3)))
    
    subplot(2,2,3)
    polar(angle(S(:,2)),abs(S(:,2)))
    
    subplot(2,2,4)
    smith(S(:,4))
    
end;