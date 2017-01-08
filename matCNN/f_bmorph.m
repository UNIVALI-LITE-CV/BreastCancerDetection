function OUT = f_bmorph(method, IN, itnum1, itnum2, objval)

% F_BMORPH Performs CNN based general binary morphology operations
%          (wave-type and iterative solution)
% 
%  Function call:
%   OUT = f_bmorph(method, IN, itnum1, itnum2, objval)
%
%  Inputs:
%   method - binary morphology operation [string]
%   IN     - input image [scalar-2d]
%   itnum1 - 1st iteration number [scalar]
%   itnum2 - 2nd iteration number [scalar]
%   objval - object value (specifies object "color") [scalar]
%
%  Output:
%   OUT  - output image [scalar-2d]

%  $Id: f_bmorph.m,v 1.7 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin<3 error('The number of input params should be at least 3!'); end
if nargin==4 objval=1; end
if nargin==3 itnum2=0; objval=1; end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.INPUT1 = objval*IN;
mCNN.STATE  = objval*IN;
mCNN.UseBiasMap=0;
mCNN.UseMask=0;
mCNN.Boundary=-objval;
mCNN.TimeStep=1;
mCNN.IterNum=1;

% run the selected method

switch (method)

case 'mwclose' % multi-step wave-type "closing"
    
    loadtem('PATCHM');
    mCNN.TimeStep=0.2;
    mCNN.IterNum=5*itnum1;
    if itnum1 runtem; end
    mCNN.I=-mCNN.I;
    mCNN.IterNum=5*itnum2;
    if itnum2 runtem; end
    
case 'mwopen' % multi-step wave-type "opening"

    loadtem('PATCHM');
    mCNN.I=-mCNN.I;    
    mCNN.TimeStep=0.2;
    mCNN.IterNum=5*itnum1;
    if itnum1 runtem; end
    mCNN.I=-mCNN.I;
    mCNN.IterNum=5*itnum2;
    if itnum2 runtem; end

case 'mclose' % multi-step morphological "closing"
    
    mCNN.Boundary=-objval;  
    mCNN.TimeStep=1.0;
    mCNN.IterNum=1;    
    
    loadtem('DILATION');
    for i=1:itnum1 runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
    
    loadtem('EROSION');
    for i=1:itnum2 runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
    
case 'mopen' % multi-step morphological "opening"
    
    mCNN.Boundary=-objval;  
    mCNN.TimeStep=1.0;
    mCNN.IterNum=1;    
    
    loadtem('EROSION');
    for i=1:itnum1 runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
    
    loadtem('DILATION');
    for i=1:itnum2 runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
    
otherwise    
    error('The specified method does not exist!')
end

% return and restore the value of external globals (ensure binary output)
if ~itnum1 & ~itnum2
    OUT  = 1*IN;
else
    OUT  = objval*2*double(grayslice(cnn2gray(mCNN.OUTPUT,0),0.5))-1;;
end
mCNN = mCNN_old;