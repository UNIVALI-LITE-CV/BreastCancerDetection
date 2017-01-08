function T = d_func(ftype,picnum)

% D_FUNC  Demonstration of the available functions of the MatCNN toolbox
% 
%  Function call:
%   T = d_func(ftype,picnum)
%
%  Inputs:
%   ftype  - function type [string]
%            / 'thresh';'histmod';'mean';'var';'dfilt';'sfilt';'fuzzy';
%              'sort';'bmorph';'edge';'skele';'segment' /
%   picnum - test picture identification number [scalar]
%            /1-14/
%
%  Output parameters (1):
%   T  - execution time in sec [scalar]

%  $Id: d_func.m,v 1.26 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% set CNN environment and initialize

cnn_setenv                    % default environment
mCNN.RunText=0;
T=cputime;

% check params

defpicnum = [4 8 4 4 4 2 2 9 9 9 9 2];
if nargin<1 error('The number of input params should be at least 1!'); end
if nargin==1 
    fsel = strncmp({'thresh';'histmod';'mean';'var';'dfilt';'sfilt';'fuzzy';...
                    'sort';'bmorph';'edge';'skele';'segment'},ftype,length(ftype));
    picind = find(fsel==1);
    if isempty(picind) error('The specified function type does not exist!'); end
    picnum = defpicnum(picind);
end

% load test picture

eval(['load data/pic' num2str(picnum)]);
[M N] = size(TESTPIC);

% test the selected function group

switch (ftype)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% THRESHOLDING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'thres'

    % set params
    thr = 0.23;
        
    % thresholding
    O1 = f_thres('fixed',TESTPIC,thr);
    O2 = f_thres('spvar',TESTPIC,thr*ones(M,N));
    O3 = f_thres('ls_adapt',TESTPIC,thr);
    O4 = f_thres('ld_adapt',TESTPIC,thr);
    O5 = f_thres('qfixed',TESTPIC,thr);
    
    % display
    figure,
    
    subplot(251), cnnshow(O1); title('Fixed')
    subplot(252), cnnshow(O2); title('Space-variant')
    subplot(253), cnnshow(O3); title('LocStat-adapt')
    subplot(254), cnnshow(O4); title('LocDyn-adapt')
    subplot(255), cnnshow(O5); title('Quick-fixed')
    subplot(256), cnnshow(O1-O5); title('Diff (F-QF)')
    subplot(257), cnnshow(O2-O5); title('Diff (S-QF)')
    subplot(258), cnnshow(O3-O5); title('Diff (LS-QF)')
    subplot(259), cnnshow(O4-O5); title('Diff (LD-QF)')
    subplot(2,5,10), cnnshow(TESTPIC); title('Original')    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%% HISTOGRAM MODIFICATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
    
case 'histmod'
    
    % set params
    
    version = 2;
    qnumber = 4;
    lambda  = 0;
    mstep = 5;
    mmode = 1;
    P = 256;
    
    % histogram modification
    switch(version)   
    case 1, % simulating the CNN transients
        [H_FILT, H_MOD, H_NORM] = ...
            f_histmod('norm-histequ-morph',TESTPIC,qnumber,lambda,mstep,mmode);
    case 2, % simulating the CNN fix-point calculations
        [H_FILT, H_MOD, H_NORM] = ...
            f_histmod('quick-norm-histequ-morph',TESTPIC,qnumber,lambda,mstep,mmode);
    case 3, % simulating the CNN fix-point calculations (C version)
        [H_FILT, H_MOD, H_NORM] = ...
            f_histmod('qnhm',TESTPIC,qnumber,lambda,mstep,mmode);        
    end
    H_EQU = gray2cnn(histeq(cnn2gray(TESTPIC))); % for comparison
    
    % display
      
    figure,
    NI = imhist(cnn2gray(TESTPIC),P);
    subplot(231), plot(1:P, NI), title('Original')
    NN = imhist(cnn2gray(H_NORM),P);
    subplot(232), plot(1:P,NN), title('Normalized')
    NM = imhist(cnn2gray(H_MOD),P);
    subplot(233), plot(1:P,NM), title('Histogram modified')
    NF = imhist(cnn2gray(H_FILT),P);
    subplot(234), plot(1:P,NF), title('Diffusion filtered')
    NE = imhist(cnn2gray(H_EQU),P);
    subplot(235), plot(1:P,NE); title('Histogram equalized')
    err = sum(abs(H_EQU-H_MOD));
    subplot(236), plot(err); title('Difference (HE-HM)')
    
    figure,
    subplot(231), cnnshow(TESTPIC); title('Original')
    subplot(232), cnnshow(H_NORM); title('Normalized')
    subplot(233), cnnshow(H_MOD); title('Histogram modified')
    subplot(234), cnnshow(H_FILT); title('Diffusion filtered')
    subplot(235), cnnshow(H_EQU); title('Histogram equalized')
    subplot(236), cnnshow(H_EQU-H_MOD); title('Difference (HE-HM)')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MEAN ESTIMATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'mean'

    % set params
    lambda = [0 0.3 0.7 1.0];
    scale = 5;
    
    % mean estimation
    O1 = f_mean('lc_diffus',TESTPIC,lambda(1),scale);
    O2 = f_mean('lc_diffus',TESTPIC,lambda(2),scale);
    O3 = f_mean('lc_diffus',TESTPIC,lambda(3),scale);
    O4 = f_mean('lc_diffus',TESTPIC,lambda(4),scale);
    
    % display
    figure,
    
    subplot(251), cnnshow(O1); title('CDIFF'), xlabel('lambda=0')
    subplot(252), cnnshow(O2); title('CDIFF'), xlabel('lambda=0.3')
    subplot(253), cnnshow(O3); title('CDIFF'), xlabel('lambda=0.7')
    subplot(254), cnnshow(O4); title('CDIFF'), xlabel('lambda=1.0')
    subplot(255), cnnshow(TESTPIC); title('Original')
    subplot(256), cnnshow(O1-TESTPIC); title('Diff')
    subplot(257), cnnshow(O2-TESTPIC); title('Diff')
    subplot(258), cnnshow(O3-TESTPIC); title('Diff')
    subplot(259), cnnshow(O4-TESTPIC); title('Diff')
    subplot(2,5,10), cnnshow(TESTPIC-TESTPIC); title('Diff')
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% VAR ESTIMATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'var'

    % set params
    scale = 1.0;
    thr   = 0.15;
        
    % var estimation
    O1 = f_var('laplace',TESTPIC,scale,thr);
    O2 = f_var('averdiff',TESTPIC,scale,thr);
    O3 = f_var('nne',TESTPIC,scale,thr);
    O4 = f_var('nnem',TESTPIC,scale,thr);
    
    % display
    figure,
    
    subplot(251), cnnshow(O1); title('Laplace')
    subplot(252), cnnshow(O2); title('AbsAvDiff')
    subplot(253), cnnshow(O3); title('NNE')
    subplot(254), cnnshow(O4); title('Mod-NNE')
    subplot(255), cnnshow(TESTPIC); title('Original')
    subplot(256), cnnshow(O1-TESTPIC); title('Diff')
    subplot(257), cnnshow(O2-TESTPIC); title('Diff')
    subplot(258), cnnshow(O3-TESTPIC); title('Diff')
    subplot(259), cnnshow(O4-TESTPIC); title('Diff')
    subplot(2,5,10), cnnshow(TESTPIC-TESTPIC); title('Diff')
    
%%%%%%%%%%%%%%%%%%%%%%%%%% DIFFUSION BASED FILTERING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'dfilt'

    % set params
    thr = 0.3;
    scale  = 10.0;
    lambda = 0.8;
    constr = 1.0;
    NTPIC = cimnoise(TESTPIC,'gaussian',0.05);
        
    % var estimation
    O1 = f_dfilt('lc_diffus',NTPIC,thr,scale,lambda,constr);
    O2 = f_dfilt('na_diffus',NTPIC,thr,scale,lambda,constr);
    O3 = f_dfilt('nba_diffus',NTPIC,thr,scale,lambda,constr);
    O4 = f_dfilt('nlca_diffus',NTPIC,thr,scale,lambda,constr);
    O5 = f_dfilt('nnca_diffus',NTPIC,thr,scale,lambda,constr);
%     O6 = f_dfilt('npde_diffus',NTPIC,thr,scale,lambda,constr);
    
    % display
    figure,
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(NTPIC-TESTPIC); title('Diff')
    subplot(243), cnnshow(O1-TESTPIC); title('Diff')
    subplot(244), cnnshow(O2-TESTPIC); title('Diff')
    subplot(245), cnnshow(O3-TESTPIC); title('Diff')
    subplot(246), cnnshow(O4-TESTPIC); title('Diff')
    subplot(247), cnnshow(O5-TESTPIC); title('Diff')
%     subplot(248), cnnshow(O6-TESTPIC); title('Diff')
    figure,    
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(NTPIC); title('Noisy')
    subplot(243), cnnshow(O1); title('LC-DIFFUS')
    subplot(244), cnnshow(O2); title('NA-DIFFUS')
    subplot(245), cnnshow(O3); title('NBA-DIFFUS')
    subplot(246), cnnshow(O4); title('NLCA-DIFFUS')
    subplot(247), cnnshow(O5); title('NNCA-DIFFUS')
%     subplot(248), cnnshow(O6); title('NPDE-DIFFUS')
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATISTICAL FILTERING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'sfilt'

    % set params
    rord = {'min';'smin';'median';'smax';'max'};
    sstep = 3;
    thr = [0.15 0.75];
    NTPIC = cimnoise(TESTPIC,'salt & pepper',0.2);
        
    % var estimation
    O1 = f_sfilt('rofilt',TESTPIC,'min',sstep,thr);
    O2 = f_sfilt('rofilt',TESTPIC,'smin',sstep,thr);
    O3 = f_sfilt('rofilt',TESTPIC,'max',sstep,thr);
    O4 = f_sfilt('rofilt',TESTPIC,'smax',sstep,thr);
    O5 = f_sfilt('rofilt',NTPIC,'median',sstep,thr);
    O6 = f_sfilt('ad-rofilt',NTPIC,'median',sstep,thr);
    
    % display
    figure,
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(NTPIC-TESTPIC); title('Diff')
    subplot(243), cnnshow(O1-TESTPIC); title('Diff')
    subplot(244), cnnshow(O2-TESTPIC); title('Diff')
    subplot(245), cnnshow(O3-TESTPIC); title('Diff')
    subplot(246), cnnshow(O4-TESTPIC); title('Diff')
    subplot(247), cnnshow(O5-TESTPIC); title('Diff')
    subplot(248), cnnshow(O6-TESTPIC); title('Diff')
    figure,    
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(NTPIC); title('Noisy')
    subplot(243), cnnshow(O1); title('MAX')
    subplot(244), cnnshow(O2); title('SMAX')
    subplot(245), cnnshow(O3); title('MIN')
    subplot(246), cnnshow(O4); title('SMIN')
    subplot(247), cnnshow(O5); title('MEDIAN')
    subplot(248), cnnshow(O6); title('AD-RO')
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% FUZZYFICATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'fuzzy',

    % set params
    mean = [-1 -0.5 0 0.5 1];
    width = [1 0.5 0.3 0.2 0.1];
        
    % fuzzyfication
    O1 = f_fuzzy('fuzzylev-radb',TESTPIC,mean(2),width(1));
    O2 = f_fuzzy('fuzzylev-radb',TESTPIC,mean(4),width(1));
    O3 = f_fuzzy('fuzzylev-radb-nn',TESTPIC,mean(2),width(1));
    O4 = f_fuzzy('fuzzylev-radb-nn',TESTPIC,mean(4),width(1));
    O5 = f_fuzzy('fuzzysim-radb',TESTPIC,mean(3),width(3));
    
    % display
    figure,
    subplot(231), cnnshow(TESTPIC); title('Original')
    subplot(232), cnnshow(O1-TESTPIC); title('Diff')
    subplot(233), cnnshow(O2-TESTPIC); title('Diff')
    subplot(234), cnnshow(O3-TESTPIC); title('Diff')
    subplot(235), cnnshow(O4-TESTPIC); title('Diff')
    subplot(236), cnnshow(O5-TESTPIC); title('Diff')
    figure,    
    subplot(231), cnnshow(TESTPIC); title('Original')
    subplot(232), cnnshow(O1); title('FUZZY-LE')
    subplot(233), cnnshow(O2); title('FUZZY-LE')
    subplot(234), cnnshow(O3); title('FUZZY-LE-NN')
    subplot(235), cnnshow(O4); title('FUZZY-LE-NN')
    subplot(236), cnnshow(O5); title('FUZZY-SE')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BINARY SORTING %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'sort'

    % force input to binary
    TESTPIC = 2*double(grayslice(cnn2gray(TESTPIC,0),0.5))-1;  
    
    % set params
    smin = [0 2 5];
    smax = [0 2 5];
    objval=1;
        
    % sorting
    O1 = f_sort('trwave',TESTPIC,smin(1),smax(2),objval);
    O2 = f_sort('trwave',TESTPIC,smin(2),smax(3),objval);
    O3 = f_sort('trwave',TESTPIC,smin(3),smax(1),objval);
    O4 = f_sort('morph',TESTPIC,smin(1),smax(1),objval);
    O5 = f_sort('morph',TESTPIC,smin(1),smax(2),objval);
    O6 = f_sort('morph',TESTPIC,smin(2),smax(3),objval);
    O7 = f_sort('morph',TESTPIC,smin(3),smax(1),objval);                            
    
    % display
    figure,
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(O1-TESTPIC); title('Diff')
    subplot(243), cnnshow(O2-TESTPIC); title('Diff')
    subplot(244), cnnshow(O3-TESTPIC); title('Diff')
    subplot(245), cnnshow(O4-TESTPIC); title('Diff')
    subplot(246), cnnshow(O5-TESTPIC); title('Diff')
    subplot(247), cnnshow(O6-TESTPIC); title('Diff')
    subplot(248), cnnshow(O7-TESTPIC); title('Diff')
    figure,    
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(O1); title('TRW'), xlabel('min-2')
    subplot(243), cnnshow(O2); title('TRW'), xlabel('2-5')
    subplot(244), cnnshow(O3); title('TRW'), xlabel('5-max')
    subplot(245), cnnshow(O4); title('BMORPH'), xlabel('0-0')
    subplot(246), cnnshow(O5); title('BMORPH'), xlabel('min-2')
    subplot(247), cnnshow(O6); title('BMORPH'), xlabel('2-5')
    subplot(248), cnnshow(O7); title('BMORPH'), xlabel('5-max')
    
%%%%%%%%%%%%%%%%%%%%%%%%%% BINARY MORPHOLOGY %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'bmorph'

    % force input to binary
    TESTPIC = 2*double(grayslice(cnn2gray(TESTPIC,0),0.5))-1;  
    
    % set params
    itnum1 = 3;
    itnum2 = 3;
    objval = 1;    
            
    % sorting
    O1 = f_bmorph('mclose',TESTPIC,itnum1,itnum2,objval);
    O2 = f_bmorph('mopen',TESTPIC,itnum1,itnum2,objval);
    O3 = f_bmorph('mwclose',TESTPIC,itnum1,itnum2,objval);
    O4 = f_bmorph('mwopen',TESTPIC,itnum1,itnum2,objval);
    
    % display
    figure,
    subplot(231), cnnshow(TESTPIC); title('Original')
    subplot(232), cnnshow(O1-TESTPIC); title('Diff')
    subplot(233), cnnshow(O2-TESTPIC); title('Diff')
    subplot(235), cnnshow(O3-TESTPIC); title('Diff')
    subplot(236), cnnshow(O4-TESTPIC); title('Diff')

    figure,
    subplot(231), cnnshow(TESTPIC); title('Original')
    subplot(232), cnnshow(O1); title('M-CLOSE'), xlabel('3-3')
    subplot(233), cnnshow(O2); title('M-OPEN'), xlabel('3-3')
    subplot(235), cnnshow(O3); title('MW-CLOSE'), xlabel('3-3')
    subplot(236), cnnshow(O4); title('MW-OPEN'), xlabel('3-3')    
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BINARY EDGE DETECTION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
case 'edge'

    % force input to binary
    TESTPIC = 2*double(grayslice(cnn2gray(TESTPIC,0),0.5))-1;  
    
    % set params
    objval=1;
            
    % edge detection
    O1 = f_edge('8c-edge',TESTPIC,-objval);
    O2 = f_edge('8c-edge',TESTPIC,objval);
    
    % display
    figure,
    subplot(231), cnnshow(TESTPIC); title('Original')
    subplot(232), cnnshow(O1); title('EdgeB')
    subplot(233), cnnshow(O2); title('EdgeW')
    subplot(234), cnnshow(O1+O2); title('EdgeB+EdgeW')
    subplot(235), cnnshow(O1-TESTPIC); title('EdgeB-Orig')
    subplot(236), cnnshow(O2-TESTPIC); title('EdgeW-Orig')

%%%%%%%%%%%%%%%%%%%%%%%%%%% BINARY SKELETONIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'skele'

    % force input to binary
    TESTPIC = 2*double(grayslice(cnn2gray(TESTPIC,0),0.5))-1;  
    
    % set params
    exord = [0 1 2 3 4 5 6 7 8 9 10 11];
    cnum = 0;
    objval = 1;
        
    % skeletonization
    O1 = f_skele('8c-skele',TESTPIC,0,cnum,objval);
    O2 = f_skele('8c-skele',TESTPIC,10,cnum,objval);
    O3 = f_skele('8c-skele',TESTPIC,10,cnum,-objval);
    O4 = f_skele('4c-skele-v1',TESTPIC,1,cnum,objval);
    O5 = f_skele('4c-skele-v1',TESTPIC,1,cnum,-objval);
    O6 = f_skele('4c-skele-v2',TESTPIC,1,cnum,objval);
    O7 = O6; %f_skele('4c-skele-v2',TESTPIC,1,cnum,-objval);
    
    % display
    figure,
    subplot(241), cnnshow(TESTPIC-(O2+O3)); title('Original-(O2+O3)')
    subplot(242), cnnshow(O1-TESTPIC); title('Diff')
    subplot(243), cnnshow(O2-TESTPIC); title('Diff')
    subplot(244), cnnshow(O3-TESTPIC); title('Diff')
    subplot(245), cnnshow(O4-TESTPIC); title('Diff')
    subplot(246), cnnshow(O5-TESTPIC); title('Diff')
    subplot(247), cnnshow(O6-TESTPIC); title('Diff')
    subplot(248), cnnshow(O7-TESTPIC); title('Diff')
    figure,    
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(O1); title('8C-SK'), xlabel('Seq:0')
    subplot(243), cnnshow(O2); title('8C-SK'), xlabel('Seq:10')
    subplot(244), cnnshow(O3); title('8C-SK'), xlabel('Seq:10')
    subplot(245), cnnshow(O4); title('4C-SK-V1'), xlabel('Seq:1')
    subplot(246), cnnshow(O5); title('4C-SK-V1'), xlabel('Seq:1')
    subplot(247), cnnshow(O6); title('4C-SK-V2'), xlabel('Seq:1')
    subplot(248), cnnshow(O7); title('4C-SK-V2'), xlabel('Seq:1')
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SEGMENTATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

case 'segment'
    
    % set def params
    PreF = [1 1 0.3];
    MeanE = [1 0.7 10];
    VarE = [1 1 0.2];
    ThreshE = [1 1 0];
    SClass = [1 3 0];
    EDet = [0 -1];
    SDet = [0 0 0 -1];
    
    % var estimation
    O1 = f_segment('fthresh',TESTPIC,PreF,MeanE,VarE,ThreshE,SClass,EDet,SDet);
    O2 = f_segment('DoG',TESTPIC,PreF,MeanE,VarE,ThreshE,SClass,EDet,SDet);
    O3 = f_segment('DoG',TESTPIC,PreF,MeanE,VarE,ThreshE,SClass,EDet,SDet);
    O4 = f_segment('adthresh',TESTPIC,PreF,MeanE,VarE,[0.5 -0.7 0],SClass,EDet,SDet);
    O5 = f_segment('adthresh',TESTPIC,PreF,MeanE,VarE,[0.5 0.7 0],SClass,EDet,SDet);
    O6 = f_segment('adthresh',TESTPIC,PreF,MeanE,VarE,[0.5 -0.5 0.5],SClass,EDet,SDet);
    O7 = f_segment('adthresh',TESTPIC,PreF,MeanE,VarE,[0 -0.5 0.5],SClass,EDet,SDet);
    
    % display
    figure,
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(O1-TESTPIC); title('Diff')
    subplot(243), cnnshow(O2-TESTPIC); title('Diff')
    subplot(244), cnnshow(O3-TESTPIC); title('Diff')
    subplot(245), cnnshow(O4-TESTPIC); title('Diff')
    subplot(246), cnnshow(O5-TESTPIC); title('Diff')
    subplot(247), cnnshow(O6-TESTPIC); title('Diff')
    subplot(248), cnnshow(O7-TESTPIC); title('Diff')
    figure,    
    subplot(241), cnnshow(TESTPIC); title('Original')
    subplot(242), cnnshow(O1); title('F'), xlabel('')
    subplot(243), cnnshow(O2); title('DoG'), xlabel('')
    subplot(244), cnnshow(O3); title('DoG'), xlabel('')
    subplot(245), cnnshow(O4); title('AF'), xlabel('')
    subplot(246), cnnshow(O5); title('AF'), xlabel('')
    subplot(247), cnnshow(O6); title('AF'), xlabel('')
    subplot(248), cnnshow(O7); title('AF'), xlabel('')
    
otherwise
     error('The specified function type does not exist!');
end

% return
T = cputime-T;