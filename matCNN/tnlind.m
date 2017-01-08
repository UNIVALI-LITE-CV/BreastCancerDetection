%  TNLIND.C  -> .MEX file : executes the specified nonlinear D-type template  
%                           on a single-layer CNN architecture with
%                           nearest neighbor interactions (two distinct
%                           inputs can be specified for nonlin function
%                           d in Dtn that can be either Ukl, Uij, X or Y)
%
%  The MATLAB calling syntax is:
%
%  [Y] = tnlind(X, Ukl, Uij, At, Bt, Dtn, d, d_inp, mCNN.I, M, h, itn, Bnd)
%			
%	 Y     -> output image
%	 X     -> state image
%	 Ukl   -> input image (neighborhood, control layer)
%	 Uij   -> input image (central cell, reference layer)
%        At    -> feedback template
%        Bt    -> control template
%	 Dtn   -> generalized nonlin template
%	 d     -> nonlin function in Dtn         
%	 d_inp -> input specification for d
%	 mCNN.I     -> constant bias or bias map 
%	 M     -> mask image
%	 h     -> time step
%	 itn   -> iteration number
%        Bnd   -> boundary specification
%	          / -1<= constant <=1, 2: zero flux, 3: torus /
%			      
%  Integration formula: Forward-Euler
%  
%  Output characteristics: sigmoid-type piecewise-linear
%
% $Id: tnlind.m,v 1.4 2003/02/12 16:54:49 rcsaba Exp $

