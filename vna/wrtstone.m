function []=wrtstone(S,freq,datapath,filename,comment,dsp);

% WRTSTONE takes as input a matrix and export it as a Touchtone file
%
% The file can be imported into a commercial circuit simulator.
% The function will check if the data matrix S has 1 or 4 coloms 
% and depending on the result, a 1-port or a 2-port Touchstone 
% file will be produced.
% 
% Input Parameters:
%
%    S          Matrix containg S-parameters
%    freq       Vector containing the frequency values (unit must be Hz)
%    datapath   Define the path to the directory in which the data is saved
%    filename   file to be generated (string)
%    comment    Name of the dependent variable (string)
%    dsp        Causes the function to echo the name and path of the file
%               that was created by the function.  This parameter is
%               optional and its default value = 0.  This suppresses output
%               to the screen.
%
% format: wrtstone(S,freq,datapath,filename,comment,dsp);
%

% Check for unspecified parameters and provide the default values

if (nargin < 6), dsp = 0; end;

% Open the specified file for writing.  Any existing file with
% this name will be over written. 

fullfilename = fullfile(datapath,filename);
fid=fopen(fullfilename,'w');

% Create the Touschtone file header.

fprintf(fid,['! ',comment,'\n']);
fprintf(fid,'! FILENAME ');fprintf(fid,filename);fprintf(fid,'\n');
fprintf(fid,'# Hz S RI R 50\n');

% Get the dimensions of the data matrix.  This will determine if a 1 port
% or two port file format should be produced

[a,b]=size(S);

% Produce a 2-port Touchstone file

if (b == 4),
    
    % Create the matrix of frequency and S-parameter data that is to be written to
    % Touchstone text file.
    
    s11(:,1)=real(S(:,1));
    s11(:,2)=imag(S(:,1));
    s21(:,1)=real(S(:,2));
    s21(:,2)=imag(S(:,2));
    s12(:,1)=real(S(:,3));
    s12(:,2)=imag(S(:,3));
    s22(:,1)=real(S(:,4));
    s22(:,2)=imag(S(:,4));
    
    f=freq;
    
    A=num2str([f s11(:,1) s11(:,2) s21(:,1) s21(:,2) s12(:,1) s12(:,2) s22(:,1) s22(:,2)],'% 20.10g\t');
    
end;

% Produce a 1-port Touchstone file

if (b == 1),
    
    % Create the matrix of frequency and S-parameter data that is to be written to
    % Touchstone text file.
    
    s11(:,1)=real(S(:,1));
    s11(:,2)=imag(S(:,1));
        
    f=freq;
    
    A=num2str([f s11(:,1) s11(:,2)],'% 20.10g\t');
    
end;

% Write the data to file.

col_number=size(A,2);
row_number=size(A,1);

for i=1:row_number
    line = [(A(i,:))];
    fprintf(fid,[line,'\n']);
end;      

% Close the text file and exit the function

fclose(fid);

% Print the filename and data path on the screen for the user

if (dsp > 0),
    disp(' ')
    disp('S-Parameter Touchstone file created')
    disp(' ')
    disp(['File: ',fullfilename])
    disp(' ')
end;


