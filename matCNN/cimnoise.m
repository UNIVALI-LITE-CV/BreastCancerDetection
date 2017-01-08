function Y = cimnoise(X, Type, P1)

% CIMNOISE   Put noise in a CNN-type image
%
% function Y = cimnoise(X, Type, P1)
%
% Inputs:
%   X    - the input CNN-type image
%   Type - noise type (see imnoise)
%   P1   - parameter (see imnoise)
%
% Output:
%   Y    - the output CNN-type image
%
% Note: The function converts a CNN-type image X to a gray scale image X'
%       and executes Y' = IMNOISE(X', Type, P1). Then converts Y' back to
%       a CNN-type image Y. (See 'imnoise' for detailed explanation)
%
%  $Id: cimnoise.m,v 1.5 2005/05/12 22:16:49 histvan Exp $
 
% check I/O params 
if nargin==2 P1=0; end             

% convert
Xi=cnn2gray(X);
Yi=imnoise(Xi, Type, P1);
Y =gray2cnn(Yi);
