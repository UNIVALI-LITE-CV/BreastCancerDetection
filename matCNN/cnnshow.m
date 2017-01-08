function [Y] = cnnshow(X, N)

% CNNSHOW  Show a CNN-type intensity image 
%
% function Y = CNNSHOW(X, N)
%
% Inputs: 
%   X - CNN-type image X (RGB or grayscale)
%   N - Colormap length to convert X to an RGB or Grayscale intensity image.
%       If it is positive then an inverted, otherwise a non-inverted
%       conversion is used. (default = 64)
% Output:
%   Y - The RGB or grayscale image, result of conversion
%
%  $Id: cnnshow.m,v 1.6 2005/05/12 22:16:49 histvan Exp $
       
% check I/O params
% eliminate singleton dimensions from input data
X = squeeze(X);
if size(X,3)==3    
  if nargin==2
    if N>0 
      Y(:,:,1) = cnn2gray(X(:,:,1));
      Y(:,:,2) = cnn2gray(X(:,:,2));
      Y(:,:,3) = cnn2gray(X(:,:,3));
    else   
      Y(:,:,1) = cnn2gray(X(:,:,1),0); 
      Y(:,:,2) = cnn2gray(X(:,:,2),0); 
      Y(:,:,3) = cnn2gray(X(:,:,3),0); 
    end;
  else    
    Y(:,:,1) = cnn2gray(X(:,:,1)); 
    Y(:,:,2) = cnn2gray(X(:,:,2)); 
    Y(:,:,3) = cnn2gray(X(:,:,3)); 
    % N=64; removed for compatibility with r14 sp1
  end
  % show image
  imagesc(Y); % ,N);  removed for compatibility with r14 sp1
  colormap gray;
else
  if nargin==2
    if N>0 
      Y = cnn2gray(X);
    else   
      Y = cnn2gray(X,0); 
    end;
  else    
    Y = cnn2gray(X); 
    % N=64; removed for compatibility with r14 sp1
  end    
  % show image
  imagesc(Y); % ,N);  removed for compatibility with r14 sp1
  colormap gray;
end

