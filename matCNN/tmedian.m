%  TMEDIAN.C	 -> .MEX file : CNN based single-layer rank order filters
%
%  The MATLAB calling syntax is:
%
%  [Y] = tmedian(X, U, Dt, slope, mCNN.I, M, h, itn, Bnd)
%			
%	 Y     -> output image
%	 X     -> state image
%	 U     -> input image
%	 Dt    -> "control" template (weighting matrix)			      
%	 slope -> slope of the nonlin function
%		  ( slope > 0  -> pwl sigmoid-type nf
%		    slope <=0  -> threshold-type nf  )
%        mCNN.I     -> constant bias or bias map 
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
% $Id: tmedian.m,v 1.3 2002/01/12 17:13:08 rcsaba Exp $


