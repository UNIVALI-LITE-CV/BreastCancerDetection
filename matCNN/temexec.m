function LAM = temexec(TName, TStep, INum, BCond, Transfer, UBMap, UMask)

% TEMEXEC  Execute the specified template with given parameters
%

% $Id: temexec.m,v 1.5 2005/05/12 22:16:49 histvan Exp $
 
% declare global variables of the CNN environment

global mCNN
    
% check input params
if nargin<5 Transfer=''; end

% quit if the CNN environment is not loaded
if exist('mCNN')~=1 error('The CNN environment is not loaded!'); end

% save globals
UseBiasMap_old = mCNN.UseBiasMap;
UseMask_old = mCNN.UseMask;

% perform transfers
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
if nargin>=6 
   mCNN.UseBiasMap = UBMap;
end
if nargin>=7
   mCNN.UseMask = UMask;
end

% load and run the specified template
loadtem(TName);
runtem;
LAM = 1*mCNN.OUTPUT;

% restore globals
mCNN.UseBiasMap = UseBiasMap_old;
mCNN.UseMask = UseMask_old;
