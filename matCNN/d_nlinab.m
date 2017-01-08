% D_NLINAB  Sample CNN simulation with a nonlinear AB-type template

% $Id: d_nlinab.m,v 1.4 2005/05/12 22:20:50 histvan Exp $

% set CNN environment

cnn_setenv             % default environment
mCNN.TemGroup='temlib'; % default library  

% load images, initialize layers

load data\pic2           % -> TESTPIC
mCNN.INPUT1=1*TESTPIC;   % ini input
mCNN.STATE =1*TESTPIC;   % ini state

% set boundary condition

mCNN.Boundary=2;

% run nonlinear AB-type template

loadtem('GRADT');
mCNN.TimeStep=0.4;
mCNN.IterNum=25;
runtem;

% show result

subplot(121); cnnshow(mCNN.INPUT1); 
 xlabel('Input');
subplot(122); cnnshow(mCNN.OUTPUT);
 xlabel('O: Grad');
