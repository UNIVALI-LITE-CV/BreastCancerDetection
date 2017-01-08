% TLINEAR2.C	-> .MEX file :	executes the specified linear template  
%				on a single-layer CNN architecture (r = 2)
%
%  The MATLAB calling syntax is:
%
%  [Y] = tlinear(X, U, At, Bt, mCNN.I, M, h, itn, Bnd)
%			
%        Y   -> output image
%        X   -> state image
%        U   -> input image
%        At  -> feedback template
%        Bt  -> control template
%        mCNN.I   -> constant bias or bias map 
%        M   -> mask image
%        h   -> time step
%        itn -> iteration number                   
%        Bnd -> boundary specification
%		/ -1<= constant <=1, 2: zero flux, 3: torus /
%			      
%  Integration formula: Forward-Euler
%  
%  Output characteristics: sigmoid-type piecewise-linear
%
% $Id: tlinear2.m,v 1.3 2002/01/12 17:13:08 rcsaba Exp $

