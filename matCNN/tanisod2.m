%  TANISOD2.C	 -> .MEX file : CNN based anisotropic diffusion models 
%                               (non-PDE approach)
%
%  The MATLAB calling syntax is:
%
%  function [Y] = tanisod2(X, U, rvar, ovar, lambda, mCNN.I, M, cyn, h, itn, Bnd)
%
%  Inputs:
%    U      - input image
%    rvar   - neighborhood of variance calculation
%    ovar   - order (1st or 2nd) of the variance estimation
%    lamb   - scaling param (0<lamb<1), thres param, (lamb<0), no norm (lamb=0) 
%    mCNN.I - constant bias or bias map 
%    M      - mask image     
%    cyn    - cycle number
%    h      - time step
%    itn    - iteration number within a cycle
%    Bnd    - frame type (and frame value)
%                / -1<=constant<=1, 2: zero flux, 3: torus /
%  Output:
%    Y      - output image
%			             
%  Notes:
%    - orig. model: 
%        rvar=2, ovar=2; lamb=0.25, cyn=1, h=0.1, itn=50-200, Bnd=2
%    - simpl.  CNN: 
%        rvar=1, ovar=1; lamb=0.0,  cyn=5-10, h=0.1, itn=10-25, Bnd=2
%    - Integration formula: Forward-Euler
%    - Output characteristics: sigmoid-type piecewise-linear	
%
% $Id: tanisod2.m,v 1.4 2005/05/12 22:16:49 histvan Exp $





