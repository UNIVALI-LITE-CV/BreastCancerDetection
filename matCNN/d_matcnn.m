% D_MATCNN Calls and displays all MATCNN demos
%
% $Id: d_matcnn.m,v 1.4 2002/01/12 17:33:30 rcsaba Exp $

clear all, close all

% Base kernel
fprintf('\nMATCNN base kernel demonstrations:\n\n');
fprintf('Simulation example with linear AB templates!\n'), d_lin, drawnow,
fprintf('Simulation example with nonlinear AB templates!\n'), d_nlinab, drawnow,
fprintf('Simulation example with nonlinear D templates!\n'), d_nlind, drawnow,
fprintf('Simulation example for an analogic algorithm!\n'), d_algo, drawnow,

% Function level
fprintf('\nMATCNN functional level demonstrations:\n\n');
fprintf('Thresholding ...\n'), d_func('thres'); drawnow,
% fprintf('Histogram modification ...\n'), d_func('histmod'); drawnow,
fprintf('Mean calculation ...\n'), d_func('mean'); drawnow,
fprintf('Variance calculation ...\n'), d_func('var'); drawnow,
fprintf('Diffusion filtering ...\n'), d_func('dfilt'); drawnow,
fprintf('Statistical filtering ...\n'), d_func('sfilt'); drawnow,
fprintf('Fuzzification ...\n'), d_func('fuzzy'); drawnow,
fprintf('Sorting ...\n'), d_func('sort'); drawnow,
fprintf('Binary morphology ...\n'), d_func('bmorph'); drawnow,
fprintf('Skeletonization ...\n'), d_func('skele'); drawnow,
fprintf('Edge detection ...\n'), d_func('edge'); drawnow,
fprintf('Segmentation ...\n'), d_func('segment');