function [filenumber,vgsQ,vdsQ,idsQ]=getfile1(dcfile,vgsQ,vdsQ)

% GETFILE1(...) searches thru the DC data file to find the file numbers
% of the selected bias point defined by the values vgsQ and vdsQ.
%
% Input Parameters:
%
%   dcfile          String containing the name of the DCdata.txt file
%   vgsQ            Gate source bias voltage (unit = Volt)
%   vdsQ            Drain source bias voltage (unit = Volt)
%
% Output Parameter:
%
%   filenumbers     vector containing the filenumbers identifying the 
%                   s-parameter files with the Touchstone data.
%   vgsQ            Gate source bias voltage closest to the user specified
%                   bias voltage (unit = Volt)
%   vdsQ            Drain source bias voltage closest to the user specified
%                   bias voltage (unit = Volt)
%   idsQ            Drain source bias current closest to the user specified
%                   bias point (unit = Ampere)
%
% format: [filenumber,vgsQ,vdsQ,idsQ]=getfile1(dcfile,vgsQ,vdsQ);
%

% Author: Cornell van Niekerk
% Date  : 2006/08/31
%
% (c) Cornell van Niekerk
%     Dept. Electrical and Electronic Engineering
%     University of Stellenbosch
%     Stellenbosch
%     South Africa


% Load the text file containing the DC data

dcData = load(dcfile);

% Sort the results of the loaded maxtrix into vectors named to represent
% the data

vgs = dcData(:,1);
vds = dcData(:,2);
ids = dcData(:,3);
igs = dcData(:,4);

% Create a vector describing the Q-point supplied by the user

q = [ vgsQ vdsQ ];

% data vector

d = [ vgs vds ];

% Replicate the target vector for which we have to search.

qmatrix = repmat(q,length(vgs),1);

% Calculate the difference between the target vector and the data vector
% and determine the length of the difference vector.  The position of the
% minimum point in the difference vector is used to determine the bias
% point that is closest to the specified search criteria in a vector sense

delta = qmatrix - d;
for c = 1:length(vgs),
    e(c) = sqrt(dot(delta(c,:),delta(c,:)));
end;
[v,c] = min(e);

% Store the values of the bias point that is closest to the values
% specified in the search

vgsQ = vgs(c);
vdsQ = vds(c);
idsQ = ids(c);
   
% Output filenumber

filenumber = c;

