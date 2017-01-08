function OUT = f_mean(method, IN, lambda, scale)

% F_MEAN  Mean (1st moment) estimation in local neighborhood
% 
%  Function call:
%   OUT = f_mean(method, lambda, scale)
%
%  Inputs:
%   method - var estimation method [string]
%   IN     - input image [scalar-2d]
%   lambda - homotopy parameter of diff based filtering [scalar]
%   scale  - scale parameter [scalar]
%
%  Output:
%   OUT    - output image [scalar-2d]

%  $Id: f_mean.m,v 1.9 2005/05/12 22:16:49 histvan Exp $

% declare global variable of the CNN environment

global mCNN

% check I/O parameters

if nargin~=4 error('The number of input params should be 4!'); end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.INPUT1 = 1*IN;
mCNN.STATE  = 1*IN;
mCNN.UseBiasMap = 0;
mCNN.UseMask    = 0;
mCNN.Boundary   = 2;
mCNN.TimeStep   = 0.1;
mCNN.IterNum    = scale/mCNN.TimeStep;

% run the selected method

switch (method)
case 'lc_diffus'		% linear (constrained) diffusion
    
    loadtem('DIFFUSC');
    mCNN.Atem = lambda * mCNN.Atem;
    mCNN.Btem = (1-lambda) * mCNN.Btem;
    runtem;
    
otherwise    
    error('The specified method does not exist!')
end

% return and restore the value of external globals

OUT = mCNN.OUTPUT;
mCNN  = mCNN_old;