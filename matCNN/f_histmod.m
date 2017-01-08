function [FILT, MOD, NORM] = f_histmod(method, IN, qnumber, lambda, mstep, mmode)

% F_HISTMOD Performs CNN based parallel histogram modification
% 
%  Function call:
%   [FILT, MOD, NORM] = f_histmod(method, IN, qnumber, lambda, mstep, mmode)
%
%  Inputs:
%   method  - histogram modification method [string]
%   IN      - input image [scalar-2d]
%   qnumber - number of quantum levels [scalar]
%   lambda  - homotopy parameter of diff based filtering [scalar]
%   mstep   - multi-step (>0: closing, <0: opening) morphology parameter [scalar]
%   mmode   - mode of morphology operations (0 - er|dil, 1 - m(op|cl), 2 - 1:m(op|cl)) [scalar]
%
%  Outputs:
%   FILT  - filtered, histogram modified and normalized output image [scalar-2d]
%   MOD   - histogram modified and normalized output image [scalar-2d]
%   NORM  - normalized output image [scalar-2d]

%  $Id: f_histmod.m,v 1.16 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin<4 error('The number of input params should be 3!'); end
if nargin==5 mmode=1; end
if nargin==4 mstep=0; mmode=1; end
if length(method)<4 error('Incorrect method specification!'); end
if qnumber<=1 error('Quantum number must be greater than 1!'); end
if (lambda>1 | lambda<0) error('Homotopy parameter must be within [0,1]!'); end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% set gen params

if findstr('qnhm',method)    o_flag = 1; else o_flag = 0; end % optimized without filtering
if findstr('quick',method)   q_flag = 1; else q_flag = 0; end
if findstr('norm',method)    n_flag = 1; else n_flag = 0; end
if findstr('histequ',method) h_flag = 1; else h_flag = 0; end
if findstr('morph',method)   m_flag = 1; else m_flag = 0; end
if findstr('filt',method)    f_flag = 1; else f_flag = 0; end
if findstr('view',method)    v_flag = 1; else v_flag = 0; end

% set func params

minD = -0.999; % threshold limit problem !
maxD = 1;
Drange = maxD-minD;
deltq  = Drange/qnumber;
[M N] = size(IN);

% ini processing

BIAS = zeros(M,N);
MASK = ones(M,N);
T_OUT_old = -ones(M,N);

% perform normalization and hist modification

if o_flag % optimized (mex file)
    
    QMOD = histmod(IN, 1, qnumber, mstep);
    NORM = 1*IN;
    BIAS = (ones(M,N)-QMOD)/2;
    
else % in seperate modules
    
    % perform image normalization
    
    if n_flag
        maxI = max(max(IN));
        minI = min(min(IN));
        Irange = maxI-minI;
        if Irange == 0
            error('The input image is homogeneous!'), 
        else
            NORM = (Drange/Irange)*(IN-minI*ones(M,N))+minD*ones(M,N);
        end
    else
        NORM = 1*IN;
    end
    
    % perform quantized histogram modification
    
    if h_flag
        
        for i=1:qnumber
            
            % count pixel number (area) on old thresh image
            narea(i) = size(find(T_OUT_old>0.0),1)/(M*N);
            
            % thresholding
            if ~q_flag
                mCNN.STATE  = 1*NORM;
                mCNN.BIAS  = - (maxD - i*deltq) * ones(M,N);
                if i==qnumber
                    mCNN.BIAS  = 1.01*ones(M,N);  % threshold limit problem !
                end    
                T_OUT = temexec('THRES', 0.2, 25, 1, '', 1, 0);
                T_OUT = 2*double(grayslice(cnn2gray(T_OUT,0),0.5))-1; % binary output is needed!
            else
                thr = (qnumber-i)/qnumber;
                if thr==0 thr = 0.0001; end  % threshold limit problem !
                if thr==1 thr = 0.9999; end  % threshold limit problem !
                T_OUT = 2*double(grayslice(cnn2gray(NORM,0),thr))-1;   
            end
            
            % create difference map            
            MASK   = logexec('xor',T_OUT,T_OUT_old);
                        
            % process map (multi-step morphology)
            % mmode == 0 -> mstep>0 - dilation; mstep<0 - erosion
            % mmode == 1 -> mstep>0 - mstep(closing); mstep<0 - mstep(opening)
            % mmode == 2 -> mstep>0 - 1:mstep(closing); mstep<0 - 1:mstep(opening)
            if (m_flag & mstep~=0)
                if ~q_flag
                     mCNN.Boundary=-1;                    
                     mCNN.TimeStep=0.2;
                     mCNN.IterNum=25;
                     mCNN.INPUT1=1*MASK;                    
                     mCNN.STATE=1*MASK;
                     if mmode == 1 ms = mstep; else ms = sign(mstep); end
                     while abs(ms) <= abs(mstep)
                         if ms>0
                             loadtem('DILATION');
                             for j=1:ms runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
                             if mmode
                                 mCNN.STATE=1*mCNN.OUTPUT;
                                 loadtem('EROSION');
                                 for j=1:ms runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
                             end
                         else
                             loadtem('EROSION');
                             for j=1:-ms runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
                             if mmode
                                 mCNN.STATE=1*mCNN.OUTPUT;
                                 loadtem('DILATION');
                                 for j=1:-ms runtem; mCNN.INPUT1=1*mCNN.OUTPUT; end
                             end
                         end
                         ms = ms + sign(mstep);
                     end
                     MASK = 1*mCNN.OUTPUT;
                else
                    if mmode == 1 ms = mstep; else ms = sign(mstep); end
                    while abs(ms) <= abs(mstep)
                        if ms>0
                            BW    = bwmorph(cnn2gray(MASK,0),'dilate',ms);
                            if mmode
                                MASK  = gray2cnn(double(bwmorph(BW,'erode',ms)),0);
                            else
                                MASK = gray2cnn(double(BW));
                            end
                        else
                            BW    = bwmorph(cnn2gray(MASK,0),'erode',-ms);                        
                            if mmode
                                MASK  = gray2cnn(double(bwmorph(BW,'dilate',-ms)),0);
                            else
                                MASK = gray2cnn(double(BW));
                            end
                        end
                        ms = ms + sign(mstep);
                    end
                end                
            end
                        
            % set map
            mCNN.INPUT1 = narea(i)*ones(M,N);
            mCNN.MASK   = 1*MASK;
            if ~q_flag        
                mCNN.STATE  = 1*BIAS;
                mCNN.BIAS   = 1*zeros(M,N);
                S_OUT  = temexec('SET', 0.2, 25, 0, '', 0, 1);
            else
                setind = find(mCNN.MASK>0.5);
                S_OUT  = 1*BIAS;
                S_OUT(setind) = mCNN.INPUT1(setind);
            end
            
            % store results
            T_OUT_old = 1*T_OUT;
            BIAS = 1*S_OUT;
            
            % display
            if v_flag
                if i == 1
                    figure, 
                    d = fix(sqrt(qnumber));
                    if rem(qnumber,d) m = d+1; else m = d; end;
                    n = ceil(qnumber/m);
                end
                subplot(m,n,i); cnnshow(MASK); drawnow
            end
            
        end
        
    else
        BIAS = (ones(M,N)-NORM)/2;
    end
    
end

% perform diffusion based post-processing

if f_flag
    
    mCNN.STATE  = ones(M,N)-2*BIAS;
    mCNN.INPUT1 = ones(M,N)-2*BIAS;
    mCNN.UseBiasMap=0;
    mCNN.UseMask=0;
    mCNN.Boundary=2;
    mCNN.TimeStep=0.1;
    mCNN.IterNum=50;
    loadtem('DIFFUSC');
    mCNN.Atem = lambda * mCNN.Atem;
    mCNN.Btem = (1-lambda) * mCNN.Btem;
    runtem;
    
else
    mCNN.OUTPUT  = 1*(ones(M,N)-2*BIAS);    
end

% return and restore the value of external globals

FILT  = 1*mCNN.OUTPUT;
if o_flag MOD = 1*QMOD; else MOD = ones(M,N)-2*BIAS; end
mCNN  = mCNN_old;