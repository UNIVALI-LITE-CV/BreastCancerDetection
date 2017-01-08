function OUT = f_var(method, IN, scale, thr)

% F_VAR  Variance (2nd moment) estimation in local neighborhood
% 
%  Function call:
%   OUT = f_var(method, IN, scale, thr)
%
%  Inputs:
%   method - var estimation method [string]
%   IN     - input image [scalar-2d]
%   scale  - spatial scale parameter [scalar]
%   thr    - threshold parameter [scalar-1d or 2d]
%
%  Output:
%   OUT    - output image [scalar-2d]

%  $Id: f_var.m,v 1.7 2005/05/12 22:16:49 histvan Exp $

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
mCNN.TimeStep   = 0.2;
mCNN.IterNum    = 25;

% run the selected method

switch (method)
    
case 'laplace'		% Laplace (signed aver difference)
    
    loadtem('LAPLACE');
    mCNN.Btem = scale * mCNN.Btem;    
    runtem;
    
case 'averdiff'	% abs average difference
    
    loadtem('AVERDIF'); 
    mCNN.Bt_n = scale * mCNN.Bt_n;
    runtem;
    
case 'nne'	% NNE-model
    
    loadtem('ENHEDGE');   
    mCNN.Bt_n = scale * mCNN.Bt_n;
    mCNN.nlin_b  = [0 3  -thr 1  thr 0  3 -1];
    runtem;
    
case 'nnem'	% modified NNE model
    
    loadtem('ENHEDGE');   
    mCNN.Bt_n = scale * mCNN.Bt_n;
    mCNN.nlin_b  = [0 3  -thr 1  thr 0  3 1];
    runtem;
    
otherwise    
    error('The specified method does not exist!')
end

% return and restore the value of external globals

OUT = mCNN.OUTPUT;
mCNN  = mCNN_old;