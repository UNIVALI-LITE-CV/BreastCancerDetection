function D = transfer(S)

% TRANSFER Transfer data between memory locations
%
% function D = transfer(S)
%
% Input:
%   S - source
%
% Output:
%   D - Destination
%
% Note:
%   This function corresponds to the assignment operator ('='). The only
%   differenc is that it always transfers the data to another memory location
%   than the source. It was created to deal with a bug find in MATLAB 5.x and 6.x.
%   (D=S turnes out to be only a pointer assignment if D does not exist
%   (or S is a global) and does not allocate a new memory location for D.

% $Id: transfer.m,v 1.3 2005/05/12 22:16:49 histvan Exp $

D = 1*S; % !
