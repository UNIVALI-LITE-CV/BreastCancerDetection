function LT = loadtem(TN)

% LOADTEM  Loads the specified CNN template and sets the actual linear and nonlinear 
%          feedback (mCNN.Atem, mCNN.At_n), the linear and nonlinear control (mCNN.Btem, 
%          mCNN.Bt_n), the nonlinear functions (mCNN.nlin_a, mCNN.nlin_b) and bias (mCNN.I)
%          (or a generalized nonlin interraction mCNN.Dt_n, mCNN.nlin_d) 
%          in the CNN environment according to the specified template 
%          name (mCNN.TemName <- TN).
% Input:
%  TN - The name of the tempplate to load
% Output:
%  LT - The type of the template loaded (LT <- mCNN.TemType).
%
% $Id: loadtem.m,v 1.5 2005/05/12 22:16:49 histvan Exp $

% declare global variables

global mCNN

% global TemGroupOld % internal static     

% quit if the CNN environment is not loaded

if exist('mCNN')~=1 error('The CNN environment is not loaded!'); end

% set template environment

eval(mCNN.TemGroup);

% set globals 

mCNN.Nbr=1; mCNN.TemName=TN; mCNN.TemType=0;

% set internal variables 

TemExists=0;

% linear

FillAtem = 0;
if exist([mCNN.TemName '_A'])
   % clear mCNN.Atem, global mCNN.Atem
   eval(['mCNN.Atem = ' mCNN.TemName '_A(:);']);
   if size(mCNN.Atem) == [25 1] mCNN.Nbr = 2; end
   TemExists=1; 
else FillAtem = 1; end

FillBtem = 0;
if exist([mCNN.TemName '_B'])
   % clear mCNN.Btem, global mCNN.Btem  
   eval(['mCNN.Btem = ' mCNN.TemName '_B(:);']); 
   if size(mCNN.Btem) == [25 1] mCNN.Nbr = 2; end
   TemExists=1;
else FillBtem = 1; end

if FillAtem == 1
   mCNN.Atem=zeros((2*mCNN.Nbr+1)^2,1);
end   
if FillBtem == 1
   mCNN.Btem=zeros((2*mCNN.Nbr+1)^2,1);
end   

% nonlinear

if exist([mCNN.TemName '_Aa']) 
   eval(['mCNN.At_n = ' mCNN.TemName '_Aa(:);']); TemExists=1; mCNN.TemType=1; else mCNN.At_n=zeros(9,1); end  
if exist([mCNN.TemName '_a'])
   eval(['mCNN.nlin_a = ' mCNN.TemName '_a;']); else mCNN.nlin_a=[0 0]; end

if exist([mCNN.TemName '_Bb'])  
   eval(['mCNN.Bt_n = ' mCNN.TemName '_Bb(:);']); TemExists=1; mCNN.TemType=1; else mCNN.Bt_n=zeros(9,1); end   
if exist([mCNN.TemName '_b']) 
   eval(['mCNN.nlin_b = ' mCNN.TemName '_b;']); else mCNN.nlin_b=[0 0]; end

if exist([mCNN.TemName '_Dd'])  
   eval(['mCNN.Dt_n = ' mCNN.TemName '_Dd(:);']); TemExists=1; mCNN.TemType=2; else mCNN.Dt_n=zeros(9,1); end   
if exist([mCNN.TemName '_d']) 
   eval(['mCNN.nlin_d = ' mCNN.TemName '_d;']); else mCNN.nlin_d=[0 0]; end

% bias

if exist([mCNN.TemName '_I'])
   eval(['mCNN.I = ' mCNN.TemName '_I;']); TemExists=1; else mCNN.I=0; end      

% quit if the specified template does not exist

if TemExists==0 error('The specified template does not exist!'); end

% return 

LT=mCNN.TemType;