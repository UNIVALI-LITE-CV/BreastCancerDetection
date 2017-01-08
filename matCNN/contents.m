% CONTENTS of MatCNN - Analogic CNN Simulation Toolbox for MATLAB
%
%  / an easy and flexible test environment for single-layer analogic CNN 
%    algorithms with nearest and second neighbor linear and nonlinear interactions /
%
% Analogic Cellular Neural/Nonlinear Network Simulation Toolbox.
% Version 2.1  1-April-2005
% Csaba Rekeczky
% Copyright (c) 2001 AnaLogic Computers Ltd
% E-mail: rcsaba@analogic-computers.com or rcsaba@sztaki.hu
%
% $Id: contents.m,v 1.5 2005/05/12 22:16:49 histvan Exp $
%
% Requirements: Matlab core and the Image Processing Toolbox
%
% Basic scripts and functions:
%   cnn_setenv    - set CNN environment and initialize global variables (script)
%   showenv   - show global variables of the CNN environment (script)
%   loadtem   - load the specified CNN template (function)
%   showtem   - show the actual template loaded into the CNN environment (script)
%   runtem    - run the specified CNN template (function)
%   temexec   - execute template operation (script)
%   temexecf  - execute template operation (function)
%   logexec   - execute logical function (function)
%   cnnshow   - show a CNN-type intensity image (function)
%   cnnmshow  - show multiple CNN-type intensity images (function)
%   temlib    - default CNN template library (script)
%   transfer  - transfer in between two CNN-type image memories (function)
%
% CNN based image processing functions:
%   f_bmorph      - binary morphology
%   f_breconstr   - binary object reconstruction
%   f_dfilt	    - linear and nonlinear diffusion based filtering 
%   f_edge	    - edge detection
%   f_fuzzy	    - fuzzy decomposition
%   f_histmod  	- histgoram modification
%   f_mean        - mean filtering
%   f_segment 	- gray-scale image segmentation
%   f_sfilt	    - statistic filtering
%   f_skele 	    - skeletonization
%   f_sort	    - sized based binary object sorting
%   f_thres	    - thresholding
%   f_var  	    - variance filtering
%
% Miscellaneous functions:
%   cnn2gray  - convert a CNN-type image to a gray-scale intensity image
%   gray2cnn  - convert a gray-scale intensity image to a CNN-type image
%   cbound    - add a specified boundary to a CNN-type image
%   cimnoise  - put noise in a CNN-type image
%   scnn2bmp  - save a CNN-type image to disk in BMP format
%   lbmp2cnn  - load a BMP file from disk and convert it to a CNN-type image
%   scnn2avi  - save a CNN-type image into an avi stream
%   lavi2cnn  - load an avi frame and convert it to a CNN-type image
%
% Basic MEX-files:
%   tlinear   - linear CNN template simulation (1st nbr)
%   tlinear2  - linear CNN template simulation (2nd nbr)
%   tnlinab   - nonlinear AB-type CNN template simulation (1st nbr)
%   tnlind    - nonlinear D-type CNN template simulation (2nd nbr)
%
% Special MEX-files implementing nonlinear filters:
%   histmod   - histogram modification (CNN t.s. and digital)
%   tmedian   - median (ranked order) CNN template simulation
%   tmedianh  - median (ranked order) CNN t.s. (for switch analysis)
%   tanisod   - anisotropic (nonlinear) CNN template simulation - single layer models
%   tanisod2  - anisotropic (nonlinear) CNN template simulation - multi-layer models
%   ordstat   - order statistic (OS) filters (digital)
%   modfilt   - mode filters (digital)
%   Note: There is no upper level support from the MATCNN environment for this functions.
%
% MATCNN demos:
%   d_lin     	- linear CNN template demo
%   d_nlinab  	- nonlinear AB-type template demo
%   d_nlind   	- nonlinear D-type template demo
%   d_algo    	- analogic CNN algorithm demo (combining linear and nonlinear templates)
%   d_algo_ftol	- analogic CNN algorithm demo (fault tolerance test)
%   d_func	    - demo of all functions in the toolbox
%   d_matcnn    - runs all MATCNN demos
%   showdpic    - show demo pictures of MATCNN (see MAT-files)
%
% MAT-files (images used in demonstrations):
%   pic1.mat  - 88x88
%   pic2.mat  - 88x88
%   pic3.mat  - 88x88
%   pic4.mat  - 88x88
%   pic5.mat  - 88x88
%   pic6.mat  - 256x256
%   pic7.mat  - 88x88
%   pic8.mat  - 256x256
%   pic9.mat  - 256x256
%   pic10.mat  - 88x88
%   pic11.mat  - 88x88
%   pic12.mat  - 88x88
%   pic13.mat  - 128x128
%   pic14.mat  - 128x128
%   pic15.mat  - 256x256
%   pic16.mat  - 256x256
%
% Type HELP "FName" to learn the detailes about the MATCNN scripts,
% functions and MEX-files!
