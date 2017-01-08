function [OUT, OUTE, OUTS] = f_segment(method, IN, PreF, MeanE, VarE, ThreshE, SClass, EDet, SDet)

% F_SEGMENT Segmentation based on geometry-driven diffusion and statistical filtering.
%           Uses an adaptive thresholding scheme that incorporates both the estimates 
%           of the first (mean) and second (variance) order statistics
% 
%  Function call:
%   OUT = f_segment(method, IN, PreF, MeanE, VarE, ThreshE, SClass, EDet)
%
%  Inputs:
%   method - segmentation method [string]
%   IN     - input image [scalar-2d]
%   PreF   - prefiltering params [scalar-1d]
%   MeanE  - mean estimation params [scalar-1d]
%   VarE   - variance estimation params [scalar-1d]
%   ThreshE- threshold estimation params [scalar-1d]
%   SClass - size calssification params [scalar-1d]
%   EDet   - edge detection [scalar-1d]
%   SDet   - skeleton detection [scalar-1d]
%
%  Outputs:
%   OUT   - output image (segmentation result) [scalar-2d]
%   OUTE  - output image (segmentation edge) [scalar-2d]
%   OUTS  - output image (segmentation skeleton) [scalar-2d]

%  $Id: f_segment.m,v 1.6 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

% check I/O parameters

if nargin ~= 9 error('The number of input params should be 9!'); end

% initialize and set global params
S=size(IN);

% set default params

% prefiltering
pf_method = 'lc_diffus';
pf_thr = 0.2; pf_scale = 1.5; pf_lambda = 0.2; pf_constr = 1;
% mean estimation
me_method = 'lc_diffus';
me_lambda = 0.8; me_scale = 20;
% var estimation
ve_method = 'laplace';
ve_scale = 1; ve_thr = 0.15;
% threshold estimation
alpha=0.5;
beta=-0.7; 
% thresholding
th_method = 'spvar';
th_thr = 0;
% binary size classification
sc_method = 'morph';
sc_smin = 3; sc_smax = 0;
% binary edge detection
ed_method = '8c-edge';
ed_bcond = -1;
% binary skeletonization
sd_method = '8c-skele';
sd_exord = 0; sd_cnum = 0; sd_bcond = -1;

% set specified parameters

switch (method)
    
case 'fthresh',       % fixed thresholding
    
    % prefiltering
    pf_scale = PreF(2); pf_lambda = PreF(3);
    % thresholding
    alpha=0; beta=0; 
    th_method = 'spvar'; th_thr = ThreshE(3);
    % size classification
    if SClass(1)
        sc_smin = SClass(2); sc_smax =SClass(3);
    end
    % post processing
    if EDet(1)
        ed_bcond = EDet(2);
    end
    if SDet(1)
        sd_exord = SDet(2); sd_cnum = SDet(3); sd_bcond = SDet(4);
    end
    
case 'DoG',  	 % DoG, adaptive thresholding with mean estimation
    
    % prefiltering
    pf_scale = PreF(2); pf_lambda = PreF(3);
    % mean estimation
    me_lambda = MeanE(2); me_scale = MeanE(3);
    % thresholding
    alpha=ThreshE(1); beta=0;
    th_method = 'spvar'; th_thr = ThreshE(3);
    % size classification
    if SClass(1)
        sc_smin = SClass(2); sc_smax =SClass(3);
    end
    % post processing
    if EDet(1)
        ed_bcond = EDet(2);
    end
    if SDet(1)
        sd_exord = SDet(2); sd_cnum = SDet(3); sd_bcond = SDet(4);
    end
    
case 'adthresh', % adaptive thresholding with mean and var estimation
    
    % prefiltering
    pf_scale = PreF(2); pf_lambda = PreF(3);
    % mean estimation
    me_lambda = MeanE(2); me_scale = MeanE(3);
    % variance estimation
    ve_scale = VarE(2); ve_thr = VarE(3);
    % threshold estimation
    alpha=ThreshE(1); beta=ThreshE(2);
    th_method = 'spvar'; th_thr = ThreshE(3);
    % size classification
    if SClass(1)
        sc_smin = SClass(2); sc_smax =SClass(3);
    end
    % post processing
    if EDet(1)
        ed_bcond = EDet(2);
    end
    if SDet(1)
        sd_exord = SDet(2); sd_cnum = SDet(3); sd_bcond = SDet(4);
    end
otherwise
    error('The specified method does not exist!')
end


% run the selected method with the specified params

% pre-filtering
if (PreF(1)) 		% diffusion based filter
    PFILT = f_dfilt(pf_method, IN, pf_scale, pf_lambda, pf_constr);
else
    PFILT = 1*IN;  
end

% mean and variance estimation
% in local neighborhood

if (alpha & MeanE(1))
    MEAN = f_mean(me_method, IN, me_lambda, me_scale);
else
    MEAN = ones(S);
end

if (beta & VarE(1))
    VAR = f_var(ve_method, IN, ve_scale, ve_thr);
else
    VAR = ones(S);
end

% calculate bias map for adaptive thresholding

SPTHR=-(alpha*MEAN+beta*VAR+th_thr*ones(S));

% thresholding

SEGM = f_thres(th_method, PFILT, SPTHR);

% binary post processing of the adapt output

% size classification (sorting)
if SClass(1)    
    OUT = f_sort(sc_method, SEGM, sc_smin, sc_smax);
else   
    OUT = SEGM; 
end   

% binary edge detection
if EDet(1)    
    OUTE = f_edge(ed_method, OUT, ed_bcond);
else    
    OUTE = OUT;
end

% binary skeletonization
if SDet(1)    
    OUTS = f_skele(sd_method, OUT, sd_exord, sd_cnum, sd_bcond);
else    
    OUTS = OUT;
end
