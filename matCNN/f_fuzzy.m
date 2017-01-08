function OUT = f_fuzzy(method, IN, mean, width)

% F_FUZZY Performs CNN based "fuzzyfication"
% 
%  Function call:
%   OUT = f_fuzzy(method, IN)
%
%  Inputs:
%   method  - fuzzyfication method [string]
%   IN      - input image [scalar-2d]
%   mean    - mean value of the fuzzy membership function [scalar]
%   width   - width of the fuzzy membership function [scalar]
%
%  Output:
%   OUT  - output image [scalar-2d]

%  $Id: f_fuzzy.m,v 1.4 2005/05/12 22:16:49 histvan Exp $

% declare global variables of the CNN environment

global mCNN

% check I/O parameters

if nargin~=4 error('The number of input params should be 3!'); end

% store the value of external globals already set in the workspace

mCNN_old = mCNN;

% set template library

mCNN.TemGroup='temlib';

% initialize and set globals

mCNN.STATE      = 1*IN;
mCNN.INPUT2     = 1*IN;
mCNN.UseBiasMap = 0;
mCNN.UseMask    = 0;
mCNN.Boundary   = 2;
mCNN.TimeStep   = 0.2;
mCNN.IterNum    = 25;

% run the selected method

switch method
    
case 'fuzzylev-radb', % fuzzy mean level estimation with a radial basis function
    
mCNN.INPUT1=mean*ones(size(IN));
loadtem('FUZZY');
Dt_n = [0 0 0; 0 1 0; 0 0 0];
nlin_d  = [1 5  -2.5 0  -width/2 0  0 1  width/2 0  2.5 0  11];
runtem;
        
case 'fuzzylev-radb-nn', % fuzzy mean level estimation with a radial basis function
                          % and nearest neighbor weigting
    
mCNN.INPUT1=mean*ones(size(IN));
loadtem('FUZZY');
nlin_d  = [1 5  -2.5 0  -width/2 0  0 1  width/2 0  2.5 0  11];
runtem;

case 'fuzzysim-radb', % fuzzy similarity estimation with a radial basis function

mCNN.INPUT1=1*IN;
loadtem('FUZZY');
Dt_n = 1/8*[1 1 1; 1 0 1; 1 1 1];
nlin_d  = [1 5  -2.5 0  mean-width/2 0  mean 1  mean+width/2 0  2.5 0  11];
runtem;
    
otherwise    
    error('The specified method does not exist!')
end

% return and restore the value of external globals

OUT  = mCNN.OUTPUT;
mCNN = mCNN_old;