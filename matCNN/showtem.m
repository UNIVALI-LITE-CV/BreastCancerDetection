% SHOWTEM  Show the actual template loaded into the CNN environment
%
% $Id: showtem.m,v 1.4 2003/05/03 14:15:00 rcsaba Exp $
 
format compact

% declare global variables

global mCNN

% quit if the CNN environment is not loaded

if exist('mCNN')~=1 error('The CNN environment is not loaded!'); end

% show template

mCNN.Atem,
mCNN.Btem,
mCNN.At_n,
mCNN.nlin_a,
mCNN.Bt_n,
mCNN.nlin_b,
mCNN.Dt_n,
mCNN.nlin_d,
mCNN.I