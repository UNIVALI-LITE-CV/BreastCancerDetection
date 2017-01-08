function [Y] = cnn2gray(X, c_flag)

% CNN2GRAY Convert a CNN-type image to a gray scale intensity image.
%
% function [Y] = cnn2gray(X, c_flag)
%
% Inputs:
%  X      - CNN-type image
%  c_flag - inversion flag (default = 1)
%           0 - normal conversion
%           1 - inverted conversion
% Output:
%  Y      - converted grayscale image

%  $Id: cnn2gray.m,v 1.7 2005/05/12 22:16:49 histvan Exp $

global mCNN;

% check params
if nargin==1 c_flag=1; end 

% convert
S=size(X);
if c_flag
 Y=ones(S)+(ones(S)+X)/(-2);  
else
 Y=(ones(S)+X)/2;
end

% force binary output
if (isfield(mCNN,'CNN_BIN') & mCNN.CNN_BIN == 1)
    Y=round(Y);
end