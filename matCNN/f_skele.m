function OUT = f_skele(method, IN, exord, cnum, objval)

% F_SKELE Performs CNN based binary skeletonization
% 
%  Function call:
%   OUT = f_skele(method, IN, exord, cnum, objval)
%
%  Inputs:
%   method - skeletonization method [string]
%   IN     - input image [scalar-2d]
%   exord  - (coded) execution order of directional peeling [scalar]
%   cnum   - cycle number [scalar]
%   objval - object value (specifies object "color") [scalar]
%
%  Output:
%   OUT  - output image [scalar-2d]

%  $Id: f_skele.m,v 1.12 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin < 2 error('The number of input params should be at least 2!'); end
if nargin < 3 exord  = 0; end
if nargin < 4 cnum = 0; end
if nargin < 5 objval = 1; end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.INPUT1 = objval*IN;
mCNN.STATE  = objval*IN;
mCNN.MASK   = objval*IN;
mCNN.UseBiasMap = 0;
mCNN.UseMask    = 1;
mCNN.Boundary   = -objval;
mCNN.TimeStep   = 1;
mCNN.IterNum    = 1;

% select method (CNN template sequence base name)

switch (method)    
case '8c-skele'
    TBName = 'SKELE';  
case '4c-skele-v1'
    TBName = 'SKLHV';
case '4c-skele-v2'
    TBName = 'SKL';   
otherwise    
    error('The specified method does not exist!');
end   

% select execution order of template sequence

switch (exord)
case {0,10}, tseq = [1 2 3 4 5 6 7 8];
case {1,11}, tseq = [8 7 6 5 4 3 2 1];
case 2, tseq = [1 5 2 6 3 7 4 8];
case 3, tseq = [5 1 6 2 7 3 8 4];
case 4, tseq = [1 5 3 7];
case 5, tseq = [2 6 4 8];
case 6, tseq = [5 7 1 3];
case 7, tseq = [6 8 2 4];
case 8, tseq = [1 3 5 7];
case 9, tseq = [2 4 6 8];    
otherwise
    error('The specified (coded) execution order does not exist!')    
end   

% run the selected method

% ini
if (cnum==0 | cnum>500) cycle=1000; else cycle=1*cnum; end  % set max cycle number
LAM1=1*IN;
k = 1;

% run
while(cycle>0)   
    
    % skeletonize
    for i = 1:size(tseq,2)  
        TN = [TBName num2str(tseq(i))];
        loadtem(TN);
        runtem;
        mCNN.INPUT1=1*mCNN.OUTPUT;
    end
    
    % alternate methods (0<->1 only!)
    if exord >= 10 & exord <= 11
        tseq = 9*ones(size(tseq))-tseq;
    end   
    
    % check whether steady-state has been reached
    LAM2=LAM1-mCNN.OUTPUT;
    errv(k) = size(find(LAM2~=0),1);
    if (errv(k) == 0)   
        cycle=0;
    else 
        LAM1=1*mCNN.OUTPUT;
        cycle=cycle-1;
    end
    k = k + 1;
    
end

% ensure binary output

mCNN.OUTPUT = 2*double(grayslice(cnn2gray(mCNN.OUTPUT,0),0.5))-1;   

% return and restore the value of external globals

OUT  = objval*mCNN.OUTPUT;
mCNN = mCNN_old;