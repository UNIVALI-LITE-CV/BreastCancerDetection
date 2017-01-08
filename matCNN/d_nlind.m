% D_NLIND  Sample CNN simulation with a nonlinear D-type template

% $Id: d_nlind.m,v 1.4 2005/05/12 22:20:50 histvan Exp $

% set CNN environment

cnn_setenv             % default environment
mCNN.TemGroup='temlib'; % default library  

% load images, initialize layers

load data\pic2           % -> TESTPIC
mCNN.INPUT1=1*TESTPIC;   % ini input
mCNN.STATE =1*TESTPIC;   % ini state

% put noise in the image

% mCNN.STATE=cimnoise(mCNN.STATE, 'gaussian',0.01);
mCNN.STATE=cimnoise(mCNN.STATE, 'salt & pepper',0.05);

mCNN.INPUT1=1*mCNN.STATE;                                            
mCNN.INPUT2=1*mCNN.STATE;  % 2nd input!

% set boundary condition

mCNN.Boundary=2;

% run nonlinear D-type template

loadtem('MEDIAN');
mCNN.TimeStep=0.02;
mCNN.IterNum=50;
runtem;

% show result

subplot(121); cnnshow(mCNN.INPUT1); 
 xlabel('Input');
subplot(122); cnnshow(mCNN.OUTPUT);
 xlabel('O: Median');
