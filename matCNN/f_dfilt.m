function OUT = f_dfilt(method, IN, thr, scale, lambda, constr)

% F_DFILT Performs CNN based geometry-driven diffusion based filtering
% 
%  Function call:
%   OUT = f_dfilt(method, IN, thr, scale, lambda, constr)
%
%  Inputs:
%   method  - diffusion method [string]
%   IN      - input image [scalar-2d]
%   thr     - threshold parameter [scalar]
%   scale   - time scale parameter [scalar]
%   lambda  - homotopy parameter [scalar]
%   constr  - constraint parameter [scalar]
%
%  Outputs:
%   OUT  - output image [scalar-2d]
%
%  Remarks: -
%
%  $Id: f_dfilt.m,v 1.8 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters, set def values

if nargin<3 error('The number of input params should be at least 3!'); end
if nargin<3 thr=0.2; end
if nargin<4 scale=5; end
if nargin<5 lambda=0.5; end
if nargin<6 constr=1; end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.INPUT1 = 1*IN;
mCNN.INPUT2 = 1*IN;
mCNN.STATE  = 1*IN;
mCNN.UseBiasMap = 0;
mCNN.UseMask    = 0;
mCNN.Boundary   = 2;
mCNN.TimeStep   = 0.1;
mCNN.IterNum    = scale/mCNN.TimeStep;

% run the selected method

switch (method)
    
case 'lc_diffus'	% linear (constrained) diffusion
    
    loadtem('DIFFUSC');
    mCNN.Atem = lambda * mCNN.Atem;
    mCNN.Btem = (1-lambda) * mCNN.Btem;
    runtem;
    
case 'na_diffus'	% nonlinear - anisotropic - diffusion (P-M model)
    
    loadtem('ANISO');
    mCNN.nlin_d = [1 5  -2 0  -thr 0  0 1  thr 0  2 0  122];
    runtem;
    
case 'nba_diffus'	% nonlinear (biased) - anisotropic - diffusion (N's model)
    
    mCNN.UseBiasMap=1;
    mCNN.BIAS=1*IN;
    loadtem('ANISOC');
    mCNN.nlin_d = [1 5  -2 0  -thr 0  0 1  thr 0  2 0  122];
    runtem;
    
case 'nlca_diffus'	% nonlinear (lin constrained -> convolution output) 
    % - anisotropic - diffusion
    
    LAM1=1*mCNN.STATE;
    loadtem('AVERAGE');
    mCNN.Btem = (1/(4*constr)) * [constr/4 constr/2 constr/4; 
        constr/2 constr   constr/2; 
        constr/4 constr/2 constr/4];
    mCNN.TimeStep=0.2;
    mCNN.IterNum=25;
    runtem;
    
    mCNN.BIAS=1*mCNN.OUTPUT;
    mCNN.STATE=1*LAM1;
    mCNN.UseBiasMap=1;
    loadtem('ANISOC');
    mCNN.nlin_d = [1 5  -2 0  -thr 0  0 1  thr 0  2 0  122];
    mCNN.TimeStep=0.1;
    mCNN.IterNum=scale/mCNN.TimeStep;
    runtem;
    
case 'nnca_diffus'	% nonlinear (nlin constrained -> RO filter output) 
    % - anisotropic - diffusion
    
    LAM1=1*mCNN.STATE;
    loadtem('MEDIAN');
    mCNN.I=1*constr;
    mCNN.TimeStep=0.02;
    mCNN.IterNum=50;
    runtem;
    
    mCNN.BIAS=1*mCNN.OUTPUT;
    mCNN.STATE=1*LAM1;
    mCNN.UseBiasMap=1;
    loadtem('ANISOC');
    mCNN.nlin_d = [1 5  -2 0  -thr 0  0 1  thr 0  2 0  122];
    mCNN.TimeStep=0.1;
    mCNN.IterNum=scale/mCNN.TimeStep;
    runtem;
    
case 'npde_diffus' % non-PDE based approach
    
    mCNN.INPUT1=mCNN.STATE;
    [mCNN.OUTPUT]=tanisod2(mCNN.STATE, mCNN.INPUT1, 2, 1, 0.25, ...
        0, 0, 1, mCNN.TimeStep, mCNN.IterNum, mCNN.Boundary);
    
otherwise    
    error('The specified method does not exist!')
end

% return and restore the value of external globals

OUT  = mCNN.OUTPUT;
mCNN = mCNN_old;