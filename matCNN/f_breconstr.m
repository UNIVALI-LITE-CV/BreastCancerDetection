function varargout = f_breconstr(method, IN, MARKER, MASK, Atem, b0, z0, mstep, objval)

% F_BRECONSTR Performs CNN based binary reconstruction operations
%          (wave-type and iterative solution)
% 
%  Function call:
%   OUT = f_breconstr(method, IN, MARKER, MASK, Atem, b0, z0, mstep, objval)
%
%  Inputs:
%   method - binary morphology operation [string]
%   IN     - input image (gray-scale constraints of reconstruction) [scalar-2d]
%   MARKER - marker image (seed locations of reconstruction) [scalar-2d]
%   MASK   - mask image (binary constraints of reconstruction) [scalar-2d]
%   Atem   - feedback template matrix [scalar-2d]
%   b0     - input (mask) weighting: central element of the feedforward weigting matrix [scalar-1D]
%   z0     - offset current [scalar-1D]
%   mstep  - transient length (in tau) of wave propagation/ iteration number of binary morphology [scalar-1D]
%   objval - object value (specifies object "color") [scalar]
%
%  Output:
%   OUT  - output image [scalar-2d]

%  $Id: f_breconstr.m,v 1.10 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin<4 error('The number of input params should be at least 4!'); end
if nargin==8 objval=1; end
if nargin==7 mstep=5; objval=1; end
if nargin==6 z0=3.75; mstep=5; objval=1; end
if nargin==5 b0=0; z0=3.75; mstep=5; objval=1;end
if nargin==4 Atem=[0.25 0.25 0.25; 0.25 3.00 0.25; 0.25 0.25 0.25]; b0=0; z0=3.75; mstep=5; objval=1;end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.INPUT1 = IN;
mCNN.STATE  = objval*MARKER;
mCNN.MASK   = objval*MASK;
mCNN.UseBiasMap=0;
mCNN.UseMask=0;
mCNN.Boundary=-objval;
mCNN.TimeStep=1;
mCNN.IterNum=1;

% run the selected method

switch (method)

case 'waverec' % wave-type reconstruction
    
    loadtem('PATCHMC');
    mCNN.Atem = Atem(:);
    mCNN.Btem(5) = b0;
    mCNN.I = z0;
    mCNN.UseMask = 1;    
    mCNN.TimeStep = 0.2;
    mCNN.IterNum = 5*mstep;
    if mstep runtem; end    
        
case 'wavereca' % wave-type reconstruction with adaptive transient control - experimental

    saveavi = 0;
     if saveavi
        SHOT_AVI = avifile(['f_brecdump'], 'compression', 'none');
        
     end
    
    loadtem('PATCHMC');
    mCNN.Atem = Atem(:);
    mCNN.Btem(5) = b0;
    mCNN.I = z0;
    mCNN.UseMask = 1;    
    mCNN.TimeStep = 0.2;
    mCNN.IterNum = 5;
    if mstep
        for i=1:mstep
            % store
            REF = objval*mCNN.STATE;
            % propagate for 1 tau
            runtem;

            % calculate Hamming distance
            [d1(:,i) D1(:,i)] = metrics(REF, objval*mCNN.OUTPUT,1,'Hamming',1,0);
            outedge = f_edge('8c-edge', objval*mCNN.OUTPUT, 1);
            perim(i) = sum(length(find(outedge == 1))); % perimeter of currently accepted object
            if saveavi
                outedge = f_edge('8c-edge', objval*mCNN.OUTPUT, 1);
                SHOT_OUT = gray2cnn(rgb2gray(cnnmshow(IN, outedge, 'p', 1)));
                % Save frame
                SHOT_AVI = scnn2avi (SHOT_AVI, SHOT_OUT, gray(256));
            end

            % update state for next wave-prop iteration
            mCNN.STATE = objval*mCNN.OUTPUT;
        end
        if saveavi SHOT_AVI = close(SHOT_AVI); end

    end
    otherwise
    error('The specified method does not exist!')
end

% return and restore the value of external globals

if ~mstep
    varargout{1}(:,:) = 1*MARKER;
else
    varargout{1}(:,:) = objval*mCNN.OUTPUT; % output 1: the reconstructed image
end

if nargout > 1
        varargout{2} = d1(1,:); % output distances at each iteration
        varargout{3} = perim;
end    
if nargout > 3
    fprintf('Too many output arguments for f_breconstr!\n');
end

mCNN = mCNN_old;

