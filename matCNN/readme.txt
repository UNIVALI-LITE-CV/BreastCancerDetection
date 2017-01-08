//////////////////////////////////////////////////////////////////

MATCNN, Ver. 1.0 - Installation Guide

The MATCNN Matlab Toolbox supports single-layer analogic CNN
algorithm design with linear and nonlinear templates in
MATLAB environment.

The MATCNN directory can be created under the <matlab>\TOOLBOX
where all files from the installation diskette should be copied.
Then <matlab>\TOOLBOX\MATCNN should be inserted into the directory
list of matlabrc.m to use this new toolbox as all others in MATLAB
environment.

Using MATCNN in your local environment (e.g. <home>\TEST) a startup 
M-file should be created (startup.m) specifying the location of the
toolbox: 
 e.g. addpath('C:\home\MATCNN') -> Windows
  or  addpath('/home/MATCNN')   -> UNIX

A help is available with each M- and MEX-file when typing 
"HELP file_name" according to the MATLAB conventions.


///////////////////////////////////////////////////////////////////

The MATCNN toolbox have been tested in Win'95 and SunOS 5.5.1, 
some important notes are as follows:

I.   Compiler options for creating MEX DLL-s using "cmex.bat" and
     Microsoft Visual C++ 1.52 (Matlab 4.2c.1, Windows '95 
     environment):

     cl -c -AHw -Zip -FPi87 -G3D -W3 -DDLLMEX %V35_FLAG% %1

     (huge memory model, inline coprocessor calls, proc: 386)

     cmex fname.c

     Execute the batch file "cwindows.bat" to compile all kernels of 
     the MATCNN in Windows environment.
   
II.  Options for creating MEX files in Matlab 5.0 using the script 
     "mex" and the cc compiler in Unix environment (SunOS 5.5.1) 
     (forcing compatibility with ver 4.*):

     mex -DUNIX -V4 fname.c

     Execute the script "cunix" to compile all kernels of the MATCNN
     in UNIX environment.

III. To create soft links to the existing M-files (upper case, mixed) 
     in UNIX environment execute the script file "slink".

IV.  When transfering data between LAM and LLM locations in UNIX 
     environment (Matlab 5.0) a bug was found using the assignment 
     operator (D=S). Use function "D=TRANSFER(S)" instead that 
     ensures a memory allocation for D in all cases. 

///////////////////////////////////////////////////////////////////
////