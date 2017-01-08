function OUT = f_edge(method, IN, objval)

% F_EDGE Performs CNN based binary edge detection
% 
%  Function call:
%   OUT = f_edge(method, IN, objval)
%
%  Inputs:
%   method - edge detection method [string]
%   IN     - input image [scalar-2d]
%   objval - object value (specifies object "color") [scalar]
%
%  Outputs:
%   OUT  - output image [scalar-2d]

%  $Id: f_edge.m,v 1.7 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin<2 error('The number of input params should be at least 2!'); end
if nargin==2 objval=1; end

% store the value of external globals already set in the workspace
mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.STATE      = 1*IN;
mCNN.INPUT1     = 1*IN;
mCNN.UseBiasMap = 0;
mCNN.UseMask    = 0;
mCNN.Boundary   = -objval;
mCNN.TimeStep   = 0.4;
mCNN.IterNum    = 15;

% run the selected method

switch method
    
case '8c-edge', % 8-connected edge detection
    
    loadtem('EDGE');
    if objval<0 mCNN.I=-mCNN.I; end
    runtem;
        
otherwise    
    error('The specified method does not exist!')
end

% ensure binary output

mCNN.OUTPUT = 2*double(grayslice(cnn2gray(mCNN.OUTPUT,0),0.5))-1;   

% return and restore the value of external globals

OUT  = mCNN.OUTPUT;
mCNN = mCNN_old;