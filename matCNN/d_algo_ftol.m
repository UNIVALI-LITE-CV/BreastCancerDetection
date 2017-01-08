% D_ALGO_FTOL  Sample CNN ANALOGIC ALGORITHM with linear 
%              and nonlinear templates (fault tolerance test)
%
% $Id: d_algo_ftol.m,v 1.3 2005/04/01 23:54:28 rcsaba Exp $

% set CNN environment

cnn_setenv             % default environment
mCNN.TemGroup='temlib'; % default library

% set params for fault tolerance test
mCNN.CellErrProb = 0.05;
mCNN.CellErrVal = 1.0;

% load images, initialize layers

load data\pic2           % -> TESTPIC
mCNN.INPUT1=1*TESTPIC;   % ini input
mCNN.STATE =1*TESTPIC;   % ini state

% put noise in the image

%mCNN.STATE=cimnoise(mCNN.STATE, 'gaussian',0.03);
mCNN.STATE=cimnoise(mCNN.STATE, 'salt & pepper',0.05);
mCNN.INPUT1=1*mCNN.STATE;                                            
mCNN.INPUT2=1*mCNN.STATE;  % 2nd input!
LAM1=1*mCNN.STATE;

% set boundary condition

mCNN.Boundary=2;

% run nonlinear D template

loadtem('MEDIAN');
mCNN.TimeStep=0.02;
mCNN.IterNum=50;
runtem;
LAM2=1*mCNN.OUTPUT;

% run analogic algorithm 

loadtem('THRES');
mCNN.TimeStep=0.4;
mCNN.IterNum=15;
runtem;

mCNN.INPUT1=1*mCNN.OUTPUT;
mCNN.STATE=1*mCNN.OUTPUT; 
loadtem('EDGE');
runtem;

% show results

subplot(2,2,1); cnnshow(LAM1);
 xlabel('Input');
subplot(2,2,2); cnnshow(LAM2);
 xlabel('Median');
subplot(2,2,3); cnnshow(mCNN.INPUT1);
 xlabel('Threshold');
subplot(2,2,4); cnnshow(mCNN.OUTPUT);
 xlabel('Edge');
