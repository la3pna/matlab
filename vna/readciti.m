function [IDepVarOut,DataOut]=readciti(filename,dsp);

% readciti(...) reads the content of a CITI file and return the independent
% and dependant variables in two structure variables.  The data is stored
% in the structures in the order in which they were read from the CITI
% file.  The original names and formats of the data in the CITI file is
% reported to the screen.  Screen output can be disabled by set the dsp
% parameter to 0.  The dsp parameter is optional.  Its default value is 1,
% causing output to the screen.
%
% format: [var,data]=readciti(filename,dsp);
%

% Author: Cornell van Niekerk
% Date:   2003/03/18

if (nargin == 1), dsp=1; end;

IDepVarOut=[];
DataOut=[];

if (dsp > 0), disp('  '); end;

%

fid=fopen(filename);

NumIDepVar=0;
NumDepVar=0;
IDepVarRead=0;
DepVarRead=0;

% General counter used for dependent variables

t=0;

while 1
    
    tline = fgetl(fid);
    
    if (dsp == 2), disp(tline); end;
    
    % Check for the end of the file, and if detected, jump out of the
    % current loop
    
    if ~ischar(tline), break, end;
    if  feof(fid), break, end;
    
    if strfind(tline,'VAR ')  > 0,
        
        [CW,R]=strtok(tline);
        [VN,R]=strtok(R);
        [CW,R]=strtok(R);
        [NUM,R]=strtok(R);
        
        NumIDepVar=NumIDepVar+1;
        IDepVarData{NumIDepVar,1}=VN;
        IDepVarData{NumIDepVar,2}=num2str(NUM);
               
    end;
            
    if strfind(tline,'DATA ')  > 0,

        % Get the name of the independent variables and the format in which
        % the data will be stored in the data packet
        
        [CW,R]=strtok(tline);
        [VN,R]=strtok(R);
        [FM,R]=strtok(R);
       
        % Check if the variable name contains characters that have a
        % different meaning to MATLAB and replace them with underscore
        % characters.  If the last character of a name is an underscore
        % this is stripped from the variable name.
        
        %VN=strrep(VN,'.','_');
        %VN=strrep(VN,',','_');
        %VN=strrep(VN,'[','_');
        %VN=strrep(VN,']','_');
        
        %if (VN(length(VN))=='_'), VN=VN(1:(length(VN)-1)); end
        
        % Store the variable name and 
        
        NumDepVar=NumDepVar+1;
        DepVarData{NumDepVar,1}=VN;
        DepVarData{NumDepVar,2}=FM;
       
    end;
    
    if strfind(tline,'SEG_LIST_BEGIN')  > 0,
        
        IDepVarRead=IDepVarRead+1;
        
        if (dsp == 1),
            disp(['Independent Var:  ' IDepVarData{IDepVarRead,1} '  ' IDepVarData{IDepVarRead,2}])
        end;
        
        tline = fgetl(fid);
        
        [CW,R]=strtok(tline);
        [seg_start,R]=strtok(R);
        [seg_stop,R]=strtok(R);
        [seg_number,R]=strtok(R);
        
        delta_seg=(str2num(seg_stop)-str2num(seg_start))/(str2num(seg_number)-1);
        IDepVarOut{IDepVarRead}=str2num(seg_start):delta_seg:str2num(seg_stop);
        
    end;
    
    if strcmp(tline,'VAR_LIST_BEGIN')  > 0,
        
        IDepVarRead=IDepVarRead+1;
        
        if (dsp == 1),
            disp(['Independent Var:  ' IDepVarData{IDepVarRead,1} '  ' IDepVarData{IDepVarRead,2}])
        end;
    
        c=0;
        while 1
            c=c+1;
            tline = fgetl(fid);
            if strcmp(tline,'VAR_LIST_END'), break, end
            IDepVarOut{IDepVarRead}(c)=str2num(tline);
        end;
        
    end;
    
    % Read a data package from the CITI file.
    
    if strcmp(tline,'BEGIN')  > 0,
        
        t=t+1;
        c=0;
        
        if (dsp == 1),
            disp( ['Data Packets:     ' DepVarData{t,1} '  ' DepVarData{t,2} ]);
        end;
        
        clear data
        
        while 1
            tline = fgetl(fid);
            c=c+1;            
            if strcmp(tline,'END'), break; end
            if (DepVarData{t,2}=='MA'), 
                DataOut{t}(c)=str2num(tline); 
            end;
            if (DepVarData{t,2}=='RI'), 
                [rp,im]=strtok(tline,',');
                DataOut{t}(c)=str2num(rp) + i*str2num(im);
            end;
        end;
       
    end;
   
end;
fclose(fid);


