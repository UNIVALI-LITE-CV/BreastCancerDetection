%  TMEDIANH.C	 -> .MEX file : CNN based single-layer rank order filters
%                                - experiments with hysteresis nonlinearity -
%
%  The MATLAB calling syntax is:
%
%  [Y SM TM] = tmedianh(X, U, Dt, slope, mCNN.I, M, h, itn, As, Cij, Bnd)
%			
%              Y     -> output image
%	       SM    -> matrix recording the number of switches
%	       TM    -> cell transient vector and the corr. swich vector
%	       X     -> state image
%	       U     -> input image
%	       Dt    -> "control" template			      
%	       hyst  -> hysteresis of the nonlin function
%	       mCNN.I     -> constant bias or bias map 
%	       M     -> mask image
%	       h     -> time step
%	       itn   -> iteration number                      
%	       As    -> self feedback
%	       Cij   -> cell coordinates for transient recording
%              Bnd   -> boundary specification
%	      		/ -1<= constant <=1, 2: zero flux, 3: torus /
%			      			      
%  Integration formula: Forward-Euler
%  
%  Output characteristics: sigmoid-type piecewise-linear
%
% $Id: tmedianh.m,v 1.3 2002/01/12 17:13:08 rcsaba Exp $

