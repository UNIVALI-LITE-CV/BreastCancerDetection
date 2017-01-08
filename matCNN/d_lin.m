% D_LIN  Sample CNN simulation with a linear template
%
% $Id: d_lin.m,v 1.6 2005/04/01 23:54:28 rcsaba Exp $
 
% set CNN environment

cnn_setenv             % default environment
mCNN.TemGroup='temlib'; % default library

% load images, initialize layers

load data\pic2           % -> TESTPIC
mCNN.INPUT1=1*TESTPIC;   % ini input
mCNN.STATE =1*TESTPIC;   % ini state

% set boundary condition

mCNN.Boundary=2;

% run linear template 

loadtem('DIFFUS');
mCNN.TimeStep=0.2;
mCNN.IterNum=25;
runtem;

% show result

subplot(121); cnnshow(mCNN.INPUT1);
 xlabel('Input');
subplot(122); cnnshow(mCNN.OUTPUT);
 xlabel('O: Diffus');
