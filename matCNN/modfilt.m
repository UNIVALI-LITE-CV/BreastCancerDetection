%  MODFILT.C	 -> .MEX file : implements modal filters
%
%  The MATLAB calling syntax is:
%
%  [Y] = modfilt(U, I, M, mtype, r, res, Bnd)
%		
%        Y     -> output image
%        U     -> input image
%        I     -> constant bias or bias map 
%        M     -> mask image
%	     mtype -> mode filter type
%	          0 : mode filter based on a local histogram analysis
%	          1 : truncated mean mode filter
%	          2 : truncated median mode filter
%	     r     -> neighborhood specification
%	     res   -> output resolution (or number of repetition)
%        Bnd   -> boundary specification
%	          / -1<= constant <=1, 2: zero flux, 3: torus /
%
% $Id: modfilt.m,v 1.4 2002/11/28 09:22:02 rcsaba Exp $
