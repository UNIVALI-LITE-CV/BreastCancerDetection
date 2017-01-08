% SETENV  Set CNN environment and global variable structure
%
% It createsthe following variable in the workspace:
%  mCNN - Struct to describe CNN environment

%  ??? detailed description of the environment ???

% $Id: setenv.m,v 1.7 2005/05/12 22:16:49 histvan Exp $

% set print format

format compact

% define and initialize MATCNN global variable structure


global mCNN
mCNN=struct('SimulTime',0);

mCNN.SimulTime=0; %CPU time spended to simulation
mCNN.MaxUsedLAM=0; %max number of image sized variables at runtem
mCNN.TimeComplexity=0; %summation of runing time in taus
mCNN.HWComplexity=1; %Hardware complexity of the algorithm
mCNN.Problems={}; %Error report list
%mCNN.ErvenytelenOKOK={};


% CNN architecture and operator (template)
mCNN.CNNEnv     = 1;   % status variable (0: not loaded, 1: loaded) 
mCNN.Boundary   = 2;   % boundary condition of the CNN layer (and boundary value)
                       % (-1<= constant <=1, 2: duplicated -> zero flux, 3: torus)        
mCNN.Nbr        = 1;   % maximum neigborhood of the interactions
                       % (1: 1st neighbors, 2: 2nd neighbors)
mCNN.OutputChar = 0;   % type of the output charateristics
                       % (0: sigm, 1: thresh)
mCNN.TemGroup = 'temlib'; % name of the actual template group
                          % (stored in a MATLAB script with identical name)
mCNN.TemName    = '';  % name of the actual template
mCNN.TemNum     = 0;   % number of the actual template used in the algorithm
mCNN.TemType    = -1;  % type of the actual template 
                       % (-1: notemp, 0: linear, 1; nonlinear AB, 2: nonlinear D)
mCNN.Atem       = [];  % linear feedback matrix
mCNN.Btem       = [];  % linear control matrix
mCNN.At_n       = [];  % nonlin feedback matrix
mCNN.nlin_a     = [];  % nonlin function in feedback
mCNN.Bt_n       = [];  % nonlin control matrix
mCNN.nlin_b     = [];  % nonlin function in control
mCNN.Dt_n       = [];  % generalized nonlin interaction matrix             
mCNN.nlin_d     = [];  % nonlin function in generalized term        
mCNN.I          = 0;   % cell current
mCNN.UseBiasMap = 0;   % determines whether CNN uses a space-variant current
                       % (0: no, 1: yes)
mCNN.UseMask    = 0;   % determines whether CNN operates in B&W fixed-state mode
                       % (0: no, 1: yes)

% simulation related                       
                       
mCNN.TimeStep   = 0.2; % time step of the simulation
mCNN.IterNum    = 25;  % number of steps in simulation
mCNN.RunText    = 0;   % display template name, order number,
                       % time step, number of steps and report
                       % module call before a CNN template execution
mCNN.CellErrProb = 0;  % cell error probability (for fault tolerant simulations)                       
mCNN.CellErrVal  = 0;  % fixed value of the erreneous cells (for fault tolerant simulations)                       

% miscellaneous

mCNN.CNN_BIN    = 0;   % force binary output in cnn2gray() conversion

% images assigned to the CNN layer

mCNN.INPUT1     = [];   % primary input
mCNN.INPUT2     = [];   % secondary input
mCNN.STATE      = [];   % state image
mCNN.OUTPUT     = [];   % output image
mCNN.BIAS       = [];   % bias map
mCNN.MASK       = [];   % mask image (fixed-state map)