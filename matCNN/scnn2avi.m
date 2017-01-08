function [mov] = scnn2avi(mov, X, MAP)

% SCNN2AVI  Save a CNN-type image to disk as a AVI frame
%           file with a gray-scale (256 level) colormap
%           SCNN2AVI(mov, X, MAP) writes to an AVI file containing the CNN-type
%           image X to a disk file called 'filename'. If no file extension is 
%           given with the filename, the extension '.avi' is assumed.
%
% function [mov] = scnn2avi(mov, X, MAP)
%
% Inputs:
%
% Output:

% $Id: scnn2avi.m,v 1.7 2005/05/12 22:16:49 histvan Exp $

% check I/O params

% convert
if size(X,3)==3
 GX=cnn2gray(X(:,:,1));   
 [IX gMAP]=gray2ind(GX, 256);
 if nargin <=2 MAP = gMAP; end
 mov2.cdata(:,:,1) = IX;
 GX=cnn2gray(X(:,:,2));   
 [IX gMAP]=gray2ind(GX, 256);
 mov2.cdata(:,:,2) = IX;
 GX=cnn2gray(X(:,:,3));   
 [IX gMAP]=gray2ind(GX, 256);
 mov2.cdata(:,:,3) = IX;
 mov2.colormap = MAP; %%% Dani: gMAP changed to MAP
 mov = addframe(mov, mov2);
else    
 GX=cnn2gray(X);
 if exist('MAP') == 1 
     levels = size(MAP,1);
 else
     levels = 256;
 end
 [IX gMAP]=gray2ind(GX, levels ); % Dani debug: here we pass from [0 1] to [0 255]
 if levels == 2 % binary image
    [IX gMAP]=gray2ind(255*GX, levels ); % Dani debug: here we pass from [0 1] to [0 255]
 end
 if nargin <=2 MAP = gMAP; end
 mov2.cdata = IX;
 mov2.colormap = MAP; %%% Dani: gMAP changed to MAP
 mov = addframe(mov, mov2);
end; 
