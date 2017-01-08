function [Y] = scnn2bmp(fn, X, MAP)

% SCNN2BMP  Save a CNN-type image to disk as a BMP (Microsoft Windows BitMap) 
%           file with a gray-scale (256 level) colormap
%           SCNN2BMP('filename', X, MAP) writes a BMP file containing the CNN-type
%           image X to a disk file called 'filename'. If no file extension is 
%           given with the filename, the extension '.bmp' is assumed.
%
% function [Y] = scnn2bmp(fn, X, MAP)
%
% Inputs:
%
% Output:

% $Id: scnn2bmp.m,v 1.4 2005/05/12 22:16:49 histvan Exp $

% check I/O params

% convert
if size(X,3)==3
  GX=cnn2gray(X(:,:,1));
  [IX(:,:,1) gMAP]=gray2ind(GX, 256);
  GX=cnn2gray(X(:,:,2));
  [IX(:,:,2) gMAP]=gray2ind(GX, 256);
  GX=cnn2gray(X(:,:,3));
  [IX(:,:,3) gMAP]=gray2ind(GX, 256);
  if nargin <=2 MAP = gMAP; end
  imwrite(IX, MAP, fn, 'bmp');    
else
  GX=cnn2gray(X);
  [IX gMAP]=gray2ind(GX, 256);
  if nargin <=2 MAP = gMAP; end
  imwrite(IX, MAP, fn, 'bmp');
end;  
