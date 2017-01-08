%  ORDSTAT.C	 -> .MEX file : implements order statistic filters
%
%  The MATLAB calling syntax is:
%
%  [Y] = ordstat(U, mCNN.I, M, otype, Dt, r, alfa, Bnd)
%			
%    Y     -> output image
%	 U     -> input image
%	 mCNN.I     -> constant bias or bias map 
%	 M     -> mask image
%	 otype -> order statistic filter type
%	          0 : general linear filter
%	          1 : general OS-type nonlinear filter
%	          2 : min filter
%	          3 : median filter
%	          4 : max filter
%	          5 : alfa-trimmed mean filter
%	          6 : general mean filter
%	 Dt    -> "control" template (weighting matrix)
%    r     -> neighborhood specification
%	 alfa  -> alfa param of the alfa-trimmed mean filter
%    Bnd   -> boundary specification
%	          / -1<= constant <=1, 2: zero flux, 3: torus /
%
% $Id: ordstat.m,v 1.3 2002/01/12 17:13:09 rcsaba Exp $
