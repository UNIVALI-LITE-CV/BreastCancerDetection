function OUT = f_sort(method, IN, smin, smax, objval)

% F_SORT Performs CNN based binary sorting
% 
%  Function call:
%   OUT = f_sort(method, IN, msmin, msmax, objval)
%
%  Inputs:
%   method - sorting method [string]
%   IN     - input image [scalar-2d]
%   smin   - minimum size specified in morph/wave "steps" [scalar]
%   smax   - maximum size specified in morph/wave "steps" [scalar]
%   objval - object value (specifies object "color") [scalar]
%
%  Output:
%   OUT  - output image [scalar-2d]

%  $Id: f_sort.m,v 1.9 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin<3 error('The number of input params should be at least 3!'); end
if nargin==4 objval=1; end
if nargin==3 smax=0; end
if (smax<smin & smax~=0)
    error('Maximum size cannot be smaller than the minimum size!');
end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.INPUT1 = objval*IN;
mCNN.STATE  = objval*IN;
mCNN.MASK   = objval*IN;
mCNN.UseBiasMap=0;
mCNN.UseMask=1;
mCNN.Boundary=-objval;
mCNN.TimeStep=1;
mCNN.IterNum=1;

% run the selected method

switch (method)
    
case 'trwave' % trigger-wave based sorting
    
    % eliminate smaller than the minimum size
    if smin>0
        % shrink
        loadtem('PATCHM');
        mCNN.I=-mCNN.I;
        mCNN.TimeStep=0.2;
        mCNN.IterNum=5*smin;
        runtem;
        MINO = 1*mCNN.OUTPUT;
        % reconstruct
        loadtem('RECALL');
        mCNN.IterNum=0;
        runtem;
        OUT1 = 1*mCNN.OUTPUT;
    else
        MINO = objval*IN;
        OUT1 = objval*IN;
    end
    
    % eliminate smaller than the maximum size
    if smax>0
        % shrink (further)
        mCNN.STATE  = 1*MINO;
        loadtem('PATCHM');
        mCNN.I=-mCNN.I;
        mCNN.TimeStep=0.2;
        mCNN.IterNum=5*(smax-smin);
        runtem;
        % reconstruct
        loadtem('RECALL');
        mCNN.IterNum=0;
        runtem;
        OUT2 = 1*mCNN.OUTPUT;
    else
        MAXO = objval*IN;
        OUT2 = -ones(size(IN));
    end
    
    % perform logic
    OUT  = objval*logexec('not1and',OUT2,OUT1);
    
case 'morph' % iterative binary morphological based sorting
    
    % eliminate smaller than the minimum size
    if smin>0        
        % erode
        loadtem('EROSION');
        mCNN.TimeStep=1;
        mCNN.IterNum=1;
        for i=1:smin runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
        MINO = 1*mCNN.OUTPUT;
        % reconstruct
        mCNN.INPUT1 = objval*IN;
        loadtem('RECALL');
        mCNN.IterNum=0;
        runtem;
        OUT1 = 1*mCNN.OUTPUT;
    else
        MINO = objval*IN;
        OUT1 = objval*IN;
    end
    
    % eliminate smaller than the maximum size
    if smax>0
        % erode (further)
        mCNN.STATE  = 1*MINO;
        mCNN.INPUT1 = 1*MINO;
        loadtem('EROSION');
        mCNN.TimeStep=1;
        mCNN.IterNum=1;
        for i=1:(smax-smin) runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
        % reconstruct
        mCNN.INPUT1 = objval*IN;
        loadtem('RECALL');
        mCNN.IterNum=0;
        runtem;
        OUT2 = 1*mCNN.OUTPUT;
    else
        MAXO = objval*IN;
        OUT2 = -ones(size(IN));
    end
    
    % perform logic
    OUT  = objval*logexec('not1and',OUT2,OUT1);
        
otherwise    
    error('The specified method does not exist!')
end

% return and restore the value of external globals

mCNN = mCNN_old;