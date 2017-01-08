function OUT = temexecf(INP, STA, TName, TStep, INum, BCond, Transfer, UBMap, UMask)

% TEMEXECF  The full version of the TEMEXEC function
%           (hidding all globals of the CNN environment) 

% $Id: temexecf.m,v 1.4 2005/05/12 22:16:49 histvan Exp $             

% declare global variables of the CNN environment

global mCNN
    
% check input params
if nargin<7 Transfer=''; end

% quit if the CNN environment is not loaded
if exist('mCNN')~=1 error('The CNN environment is not loaded!'); end

% save globals
mCNN_old = mCNN;

% initialize and perform transfers
mCNN.INPUT1 = 1*INP;
mCNN.STATE  = 1*STA;
if strcmp(Transfer, 'YtoX')
 mCNN.STATE = 1*mCNN.OUTPUT;  
elseif strcmp(Transfer, 'YtoU1')
 mCNN.INPUT1 = 1*mCNN.OUTPUT;
elseif strcmp(Transfer, 'YtoXU1')
 mCNN.STATE  = 1*mCNN.OUTPUT;  
 mCNN.INPUT1 = 1*mCNN.OUTPUT;
elseif strcmp(Transfer, 'U1toX')
 mCNN.STATE = 1*mCNN.INPUT1;
elseif strcmp(Transfer, 'XtoU1')
 mCNN.INPUT1 = 1*mCNN.STATE;
elseif strcmp(Transfer, '')
else
 warning('Transfer string not recognized!')  
end   
   
% set globals
mCNN.Boundary = BCond;
mCNN.TimeStep = TStep;
mCNN.IterNum  = INum;
if nargin>=8 
   mCNN.UseBiasMap = UBMap;
end
if nargin>=9
   mCNN.UseMask = UMask;
end

% load and run the specified template
loadtem(TName);
runtem;
OUT = 1*mCNN.OUTPUT;

% restore globals
mCNN = mCNN_old;