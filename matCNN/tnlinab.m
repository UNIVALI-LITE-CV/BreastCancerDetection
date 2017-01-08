%  TNLINAB.C 	 -> .MEX file : executes the specified AB-type nonlinear template  
%                                on a single-layer CNN architecture with
%                                nearest neighbor interactions 
%
%  The MATLAB calling syntax is:
%
%  [Y] = tnlinAB(X, U, At, Bt, Atn, a, Btn, b, mCNN.I, M, h, itn, Bnd)
%			
%	 Y     -> output image
%	 X     -> state image
%	 U     -> input image
%        At    -> feedback template
%        Bt    -> control template
%	 Atn   -> nonlin feedback template
%	 a     -> nonlin function in feedback
%	 Btn   -> nonlin control template			      
%	 b     -> nonlin function in control
%	 mCNN.I     -> constant bias or bias map 
%	 M     -> mask image
%	 h     -> time step
%	 itn   -> iteration number
%        Bnd   -> boundary specification
%		  / -1<= constant <=1, 2: zero flux, 3: torus /
%			      
%  Integration formula: Forward-Euler
%  
%  Output characteristics: sigmoid-type piecewise-linear
%
% $Id: tnlinab.m,v 1.3 2002/01/12 17:13:08 rcsaba Exp $

