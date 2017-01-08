% SHOWENV  Show the global variables in the CNN environment
%
% $Id: showenv.m,v 1.4 2002/01/12 17:13:09 rcsaba Exp $
 
format compact

% declare global variables

global mCNN

% quit if the CNN environment is not loaded

if exist('mCNN')~=1 error('The CNN environment is not loaded!'); end

% show environmental variables

mCNN
