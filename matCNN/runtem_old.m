function Rt = runtem()

% RUNTEM  Runs the actual CNN template (loaded by LOADTEM('mCNN.TemName')) 
%         with images given in the environment (mCNN.INPUT1, mCNN.INPUT2,
%         mCNN.STATE, mCNN.OUTPUT, mCNN.BIAS, mCNN.MASK) using the global
%         variables (mCNN.UseBiasMap, mCNN.UseMask, mCNN.Boundary) and 
%         simulation parameters (mCNN.TimeStep, mCNN.IterNum)
%
%  function Rt = runtem()
%
% Output:
%   Rt - The length of the CNN simulation in miliseconds
 
% $Id: runtem.m,v 1.7 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% quit if the CNN environment is not loaded

if exist('mCNN')~=1 error('The CNN environment is not loaded!'); end

% increment mCNN.TemNum recording the number of the used templates in the algorithm

mCNN.TemNum=mCNN.TemNum+1;

% check whether all images exist (assigned to the CNN model)

if (mCNN.TemType==2) d_inp=mCNN.nlin_d(length(mCNN.nlin_d)); end

if isempty(mCNN.STATE)
    error(' The state image (mCNN.STATE) is not initialized!'), end
if ( (any(mCNN.Btem) | any(mCNN.Bt_n) | ...
        ( any(mCNN.Dt_n) & (d_inp==11 | d_inp==12 | d_inp==13 | d_inp==21 | d_inp==31 | ...
        d_inp==111 | d_inp==112 | d_inp==113 | d_inp==121 | d_inp==131) ) ) & ... 
        isempty(mCNN.INPUT1))
    error(' Primary input (mCNN.INPUT1) is not initialized!'), end                            
if (any(mCNN.Dt_n) & (d_inp==11 | d_inp==111) & isempty(mCNN.INPUT2))                                                 
    error(' Secondary input (mCNN.INPUT2) is not initialized!'), end                            

% image size check

S=size(mCNN.STATE);
if ~isempty(mCNN.INPUT1) & S~=size(mCNN.INPUT1) 
    error(' Size of the primary input image (mCNN.INPUT1) is inconsistent with the size of the state image!'), end
if ~isempty(mCNN.INPUT2) & S~=size(mCNN.INPUT2) 
    error(' Size of the secondary input image (mCNN.INPUT2) is inconsistent with the size of the state image!'), end

% create bias map

if mCNN.UseBiasMap==1 
    if isempty(mCNN.BIAS)
        error(' Bias image (mCNN.BIAS) does not exist!');
    elseif  S~=size(mCNN.BIAS)
        error(' Size of the bias image (mCNN.BIAS) is inconsistent with the size of the state image!'), end
    BMap=1*mCNN.BIAS+mCNN.I*ones(S); 
else BMap=mCNN.I*ones(S); end 

% create mask (b&w fixed-state map)

if mCNN.UseMask==1 
    if isempty(mCNN.MASK)
        error(' Mask image does not exist!'); 
    elseif  S~=size(mCNN.MASK) 
        error(' Size of the mask image (mCNN.MASK) is inconsistent with the size of the state image!'), end
    FSMap=1*mCNN.MASK; 
else FSMap=1; end                         

% fault-tolerant simulation
if mCNN.CellErrProb ~= 0
    persistent FT_MASK CellInd    
    if isempty(FT_MASK)
        FT_MASK = ones(S);
        CellInd = fix(rand(1,fix(mCNN.CellErrProb*prod(S)))*prod(S))+1;
        FT_MASK(CellInd) = -1;
    end
    % modify CNN fix-state map and inital state     
    FSMap = logexec('and',FSMap,FT_MASK);
    mCNN.STATE(CellInd) = mCNN.CellErrVal;
end

% start the timer

t = cputime;

% execute the lin or nonlin template

if (mCNN.TemType==0)          % linear modul
    
    if mCNN.RunText==1    
        outstr=['\n Running (' num2str(mCNN.TemNum) '): ' mCNN.TemName ...
                ' (' num2str(mCNN.TimeStep) ', ' num2str(mCNN.IterNum) ') '...
                ', linear modul has been called...\n'];
        fprintf(outstr);
    end                     
    
    if mCNN.Nbr == 1
        mCNN.OUTPUT=tlinear(mCNN.STATE, mCNN.INPUT1, mCNN.Atem, mCNN.Btem, ...
            BMap, FSMap, mCNN.TimeStep, mCNN.IterNum, mCNN.Boundary);
    else
        mCNN.OUTPUT=tlinear2(mCNN.STATE, mCNN.INPUT1, mCNN.Atem, mCNN.Btem, ...
            BMap, FSMap, mCNN.TimeStep, mCNN.IterNum, mCNN.Boundary, mCNN.OutputChar);  
    end   
    
elseif (mCNN.TemType==1)      % nonlin modul AB type                 
    
    if mCNN.RunText==1    
        outstr=['\n Running (' num2str(mCNN.TemNum) '): ' mCNN.TemName ...    
                ' (' num2str(mCNN.TimeStep) ', ' num2str(mCNN.IterNum) ') '...
                ', nonlinear AB modul has been called...\n'];
        fprintf(outstr);
    end    
    
    mCNN.OUTPUT=tnlinab(mCNN.STATE, mCNN.INPUT1, mCNN.Atem, mCNN.Btem, ...
        mCNN.At_n, mCNN.nlin_a', mCNN.Bt_n, mCNN.nlin_b', ...
        BMap, FSMap, mCNN.TimeStep, mCNN.IterNum, mCNN.Boundary);
    
elseif (mCNN.TemType==2)      % nonlin modul D type
    
    if mCNN.RunText==1    
        outstr=['\n Running (' num2str(mCNN.TemNum) '): ' mCNN.TemName ...
                ' (' num2str(mCNN.TimeStep) ', ' num2str(mCNN.IterNum) ') '...
                ', nonlinear D modul has been called...\n'];
        fprintf(outstr);
    end                 
    
    mCNN.OUTPUT=tnlind(mCNN.STATE, mCNN.INPUT2, mCNN.INPUT1, ... 
        mCNN.Atem, mCNN.Btem, mCNN.Dt_n, mCNN.nlin_d', d_inp, ...
        BMap, FSMap, mCNN.TimeStep, mCNN.IterNum, mCNN.Boundary);
    
else  error('There is no template loaded to the environment!'); end 

% check the timer -> calculate return value

Rt = cputime-t;
  