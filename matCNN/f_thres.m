function OUT = f_thres(method, IN, thr)

% F_THRES Performs CNN based thresholding operations
% 
%  Function call:
%   OUT = f_thres(method, IN, thr)
%
%  Inputs:
%   method - thresholding method [string]
%   IN     - input image [scalar-2d]
%   thr    - threshold parameter [scalar-1d or 2d]
%
%  Output:
%   OUT  - output image [scalar-2d]

%  $Id: f_thres.m,v 1.12 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin~=3 error('The number of input params should be 3!'); end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.STATE      = 1*IN;
mCNN.INPUT1     = 1*IN;
mCNN.UseBiasMap = 0;
mCNN.UseMask    = 0;
mCNN.Boundary   = 2;
mCNN.TimeStep   = 0.4;
mCNN.IterNum    = 15;

% run the selected method

switch method
    
case 'fixed', % fixed thresholding
    
    loadtem('THRES');
    mCNN.I=-thr;
    runtem;
    
case 'spvar',	% space-variant thresholding with bias map
    
    mCNN.UseBiasMap=1;
    mCNN.BIAS=-thr;
    loadtem('THRES'); 
    mCNN.I=0;    
    runtem;
    
case 'ls_adapt', % locally adaptive thresholding with B-term (static)
    
    loadtem('THRES'); 
    mCNN.Btem = (1/(4*abs(thr))) * [thr/4 thr/2 thr/4; 
                                    thr/2 thr   thr/2; 
                                    thr/4 thr/2 thr/4];
    mCNN.I=-thr;
    runtem;
    
case 'ld_adapt',	% locally adaptive thresholding with AB-term (dynamic)
    
    loadtem('THRESAD'); 
    mCNN.I=-thr;
    runtem;
    
case 'qfixed', % quick fixed thresholding using 'grayslice'
    
    mCNN.OUTPUT = 2*double(grayslice(cnn2gray(mCNN.STATE,0),[(thr+1)/2]))-1;   
    
otherwise    
    error('The specified method does not exist!')
end

% ensure binary output

if ~strcmp('qfixed',method)
    mCNN.OUTPUT = 2*double(grayslice(cnn2gray(mCNN.OUTPUT,0),0.5))-1;   
end

% return and restore the value of external globals

OUT  = mCNN.OUTPUT;
mCNN = mCNN_old;