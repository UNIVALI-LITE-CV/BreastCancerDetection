%  TANISOD.C	 -> .MEX file : CNN based anisotropic diffusion models 
%                               (PDE approach)
%
%  The MATLAB calling syntax is:
%
%  function [Y Y2] = tanisod(X, U, model, At, Bt, Ct, Ctype, K, mCNN.I, M, h, itn, Bnd)
%		
% Inputs:	
%   X      - state image
%   U      - input image
%   model  - 0: Perona-Malik, Nordstrom's, Constr.; 
%            1,2: Catte, Lions et. al.
%   At     - feedback template (1st L -> 2nd L)
%   Bt     - control template	
%   Ct     - diff. "control" template
%   Ctype  - type of the nonlin diffusion function (1-4)
%   K      - noise-level estimate
%   mCNN.I - constant bias (or bias map -> Nordstrom's modification)
%   M      - mask image
%   h      - time step
%   itn    - iteration number
%   Bnd    - boundary specification
%	         / -1<= constant <=1, 2: zero flux, 3: torus /
% Outputs:		      
%	    Y     -> output of the 1st layer
%	    Y2    -> output of the 2nd layer (exists if model>1)
% Notes:
%  - Integration formula: Forward-Euler
%  - Output characteristics: sigmoid-type piecewise-linear

% $Id: tanisod.m,v 1.4 2005/05/12 22:16:49 histvan Exp $


