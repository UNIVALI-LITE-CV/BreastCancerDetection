function [Y] = gray2cnn(X, c_flag)

% GRAY2CNN Convert a gray scale intensity image to a CNN-type image.
%
% function [Y] = cnn2gray(X, c_flag)
%
% Inputs:
%  X      - grayscale image
%  c_flag - inversion flag (default = 1)
%           0 - normal conversion
%           1 - inverted conversion
% Output:
%  Y      - converted CNN-type image

% $Id: gray2cnn.m,v 1.6 2005/05/12 22:16:49 histvan Exp $

% check I/O params 
if nargin==1 c_flag=1; end 

% convert
S=size(X);
% treat different representations so that output range will be [0 1]
if isa(X,'uint8')
    maxi = 255;
elseif isa(X,'uint16')
    maxi = 65535;
elseif isa(X,'double')
    maxi = 1;
elseif isa(X,'logical')
    maxi = 1;
end

if c_flag,
  Y = -2*double(X)/maxi+ones(S); 
else
  Y =  2*double(X)/maxi-ones(S);
end
