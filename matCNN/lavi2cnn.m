function [X, MAP] = lavi2cnn(fn, i, mode)

% LAVI2CNN  Loads an image from an AVI file and
% converts it to a CNN-type image
%
% function [X, MAP] = lavi2cnn(fn, i, mode)
%
% Inputs:
%   fn   - the name of the video file (if no extension is given, '.avi' is assumed)
%   i    - the index of the frame to read out
%   mode - The color format of the output image, ('rgb', 'gray', 'bin', 'hsv').
%
% Outputs:
%   X   - The image read and converted to CNN-type
%   MAP - the actual colormap

% $Id: lavi2cnn.m,v 1.11 2005/05/12 22:16:49 histvan Exp $

 mov = aviread(fn,i);
if nargin==2
  if isempty(mov.colormap) mov.colormap = gray(256); end
  if size(mov.cdata,3) == 3
    GX = ind2gray(mov.cdata(:,:,1), mov.colormap);
    X(:,:,1) = gray2cnn(GX);
    GX = ind2gray(mov.cdata(:,:,2), mov.colormap);
    X(:,:,2) = gray2cnn(GX);
    GX = ind2gray(mov.cdata(:,:,3), mov.colormap);
    X(:,:,3) = gray2cnn(GX);      
  else    
    GX = ind2gray(mov.cdata, mov.colormap);
    X  = gray2cnn(GX);
  end 
  MAP = mov.colormap;
elseif strcmp(mode, 'gray')
  if isempty(mov.colormap) mov.colormap = gray(256); end
  if size(mov.cdata,3) == 3
      GX = ind2gray(round((double(mov.cdata(:,:,1))+double(mov.cdata(:,:,2))+double(mov.cdata(:,:,3)))/3), mov.colormap);
  else
      GX = ind2gray(mov.cdata, mov.colormap); % Dani debug: here we don't pass from [0 255] to [0 1] as assumed 
  end
  X  = gray2cnn(GX);
  MAP = mov.colormap; 
  % added by Dani
elseif strcmp(mode, 'bin')
    X  = gray2cnn(im2bw(mov.cdata, mov.colormap));
    MAP = mov.colormap; 
    % end: added by Dani
    
elseif strcmp(mode, 'rgb')
  if isempty(mov.colormap) mov.colormap = gray(256); end
  if size(mov.cdata,3) == 3
    GX = ind2gray(mov.cdata(:,:,1), mov.colormap);
    X(:,:,1) = gray2cnn(GX);
    GX = ind2gray(mov.cdata(:,:,2), mov.colormap);
    X(:,:,2) = gray2cnn(GX);
    GX = ind2gray(mov.cdata(:,:,3), mov.colormap);
    X(:,:,3) = gray2cnn(GX); 
  else
    GX = ind2gray(mov.cdata, mov.colormap);
    X = gray2cnn(GX);       
  end
  MAP = mov.colormap;
elseif strcmp(mode, 'hsv')
  hsv = rgb2hsv(mov.cdata);
  if isempty(mov.colormap) mov.colormap = gray(256); end
  X(:,:,1) = gray2cnn(hsv(:,:,1));
%  X(:,:,1) = 1.-X(:,:,1);
  X(:,:,2) = gray2cnn(hsv(:,:,2));
%  X(:,:,2) = 1.-X(:,:,2);
  X(:,:,3) = gray2cnn(hsv(:,:,3));
  MAP = mov.colormap;
elseif strcmp(mode, 'lab')
  Lab = RGB2Lab(mov.cdata);
  if isempty(mov.colormap) mov.colormap = gray(256); end
  X(:,:,1) = gray2cnn(Lab(:,:,1)/100);  
  X(:,:,2) = gray2cnn((Lab(:,:,2)+25)/25); % emphirical value
  X(:,:,3) = gray2cnn((Lab(:,:,3)+25)/25); % emphirical value
  MAP = mov.colormap;
end; 
 
