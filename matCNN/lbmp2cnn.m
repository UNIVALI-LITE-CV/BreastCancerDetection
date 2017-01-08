function [X, MAP] = lbmp2cnn(fn,mode)

% LBMP2CNN  Loads a BMP (Microsoft Windows BitMap) file and converts 
%  it to a CNN-type image
%
% function [X, MAP] = lavi2cnn(fn, i, mode)
%
% Inputs:
%   fn   - the name of the image file (if no extension is given, '.bmp' is assumed)
%   mode - The color format of the output image, ('rgb', 'gray').
%
% Outputs:
%   X   - The image read and converted to CNN-type
%   MAP - the actual colormap

% $Id: lbmp2cnn.m,v 1.6 2005/05/12 22:16:49 histvan Exp $

% convert
BPP = imread(fn);
if BPP == 24
    [IR, IG, IB] = imread(fn);
    IX = (IR+IG+IB)/3;
    MAP = gray(256);
else    
    [IX MAP] = imread(fn);    
end
if nargin == 1
  if BPP == 24
%    GX = gray2cnn(ind2gray(IR, MAP));  
%    X(:,:,1) = gray2cnn(GX);
    X(:,:,1) = gray2cnn(IR);
    X(:,:,2) = gray2cnn(IG);
    X(:,:,3) = gray2cnn(IB);
  else    
    GX = ind2gray(IX, MAP);
    X  = gray2cnn(GX);      
  end    
elseif strcmp(mode, 'rgb') 
  if BPP == 24
    X(:,:,1) = gray2cnn(IR);
    X(:,:,2) = gray2cnn(IG);
    X(:,:,3) = gray2cnn(IB);
  else    
    GX = ind2gray(IX, MAP);  
    X(:,:,1) = gray2cnn(GX);
    X(:,:,2) = gray2cnn(GX);
    X(:,:,3) = gray2cnn(GX);
  end
elseif strcmp(mode, 'gray')
  GX = ind2gray(IX, MAP);
  if BPP == 24
    X  = gray2cnn(IX);        
  else
    X  = gray2cnn(GX);        
  end
end

 
 