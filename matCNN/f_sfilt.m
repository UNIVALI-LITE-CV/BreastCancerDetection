function OUT = f_sfilt(method, IN, rord, sstep, thr)

% F_SFILT Performs CNN based robust statistical filtering 
% 
%  Function call:
%   OUT = f_sfilt(method, IN, rord, sstep, thr)
%
%  Inputs:
%   method  - thresholding method [string]
%   IN      - input image [scalar-2d]
%   rord    - rank order [string]
%   sstep   - number of operation steps [scalar]
%   thr     - threshold parameters of the NNE model [scalar-2d]
%
%  Output:
%   OUT  - output image [scalar-2d]

%  $Id: f_sfilt.m,v 1.8 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters, set def values

if nargin<3 error('The number of input params should be at least 3!'); end
defbval = [-4 -3 0 3 4];
rosel = strncmp({'min';'smin';'median';'smax';'max'},...
    rord,length(rord));
biasind = find(rosel==1);
biasval = defbval(biasind);
if nargin<4 sstep=1; end
if nargin<5 thr=[0.1 0.7]; end
if findstr(method,'quick') q_flag=1; else q_flag=0; end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.INPUT1 =1*IN;
mCNN.INPUT2 =1*IN;
mCNN.STATE = 1*IN;
mCNN.UseBiasMap = 0;
mCNN.UseMask    = 0;
mCNN.Boundary   = 2;
mCNN.TimeStep   = 0.02;
mCNN.IterNum    = 50;

% run the selected method

switch (method)
    
case 'rofilt'		% RO-filter
    
    for i=1:sstep
        loadtem('MEDIAN');
        mCNN.I=1*biasval;
        runtem;
        if i~=sstep 
            mCNN.INPUT1 = 1*mCNN.OUTPUT;
            mCNN.INPUT2 = 1*mCNN.OUTPUT;
        end
    end
    
case 'ad-rofilt'	% adaptive RO-filter
    
    for i=1:sstep
        
        % calculate the edge estimate
        
        loadtem('ENHEDGE');
        mCNN.nlin_b = [0 3  -thr(1) 1  thr(1) 0  3 -1];
        mCNN.TimeStep=0.2;
        mCNN.IterNum=25;
        runtem;
        LAM1=1*mCNN.OUTPUT;
        
        mCNN.STATE=1*LAM1;                
        mCNN.TimeStep=0.7;
        mCNN.IterNum=7;
        loadtem('THRES'); 
        mCNN.I=1*thr(2);
        runtem;
        LAM2=1*mCNN.OUTPUT;
        
        mCNN.STATE=1*(-LAM1); 
        runtem;
        LAM3=1*mCNN.OUTPUT;             
        
        mCNN.MASK=1*gray2cnn(cnn2gray(LAM2,0) | cnn2gray(LAM3,0),0);
        
        mCNN.STATE=1*LAM1;
        mCNN.UseMask=1; 
        mCNN.TimeStep=1;
        mCNN.IterNum=1;                                  
        loadtem('ZERO');
        runtem;
        
        mCNN.UseMask=0;
        mCNN.TimeStep=0.1;
        mCNN.IterNum=5;
        loadtem('DIFFUS');
        runtem;
        
        mCNN.BIAS=4.1*mCNN.OUTPUT;  % the edge estimate
        mCNN.STATE=1*mCNN.INPUT1; 
        mCNN.STATE=1*mCNN.INPUT2; 
        
        % run analogic algorithm implementing an
        % adaptive RO-filter controlled by the edge estimate
        
        mCNN.UseBiasMap=1;
        loadtem('MEDIAN');
        mCNN.I=1*biasval;
        mCNN.TimeStep=0.02;
        mCNN.IterNum=50;   
        runtem;      
        
        if i~=sstep
            mCNN.INPUT1  = 1*mCNN.OUTPUT;
            mCNN.INPUT2  = 1*mCNN.OUTPUT;
            mCNN.UseBiasMap=0;
            mCNN.UseMask=0;
        end
        
    end
    
otherwise    
    error('The specified method does not exist!')
end

% return and restore the value of external globals

OUT  = mCNN.OUTPUT;
mCNN = mCNN_old;