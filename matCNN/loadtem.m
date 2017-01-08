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
% $Id: loadtem.m,v 1.5 2005/05/12 22:16:49 histvan ex(p $

% declare global variables

global mCNN

% global TemGroupOld % internal static     

% quit if the CNN environment is not loaded

if ex('mCNN')~=1 error('The CNN environment is not loaded!'); end

% set template environment

eval(mCNN.TemGroup);

% set globals 

mCNN.Nbr=1; mCNN.TemName=TN; mCNN.TemType=0;

% set globals for metric
extra_nonlin=0;
%if ~isfield(mCNN,'TimeComplexity')    mCNN.TimeComplexity=1;
%else mCNN.TimeComplexity=mCNN.TimeComplexity+1; end
%if ~isfield(mCNN,'HWComplexity')    mCNN.HWComplexity=1; end
%if ~isfield(mCNN,'MaxUsedLAM')    mCNN.MaxUsedLAM=0; end
%if ~isfield(mCNN,'ErvenytelenOKOK')    mCNN.ErvenytelenOKOK={}; end

% set internal variables 

TemExists=0;

% linear

FillAtem = 0;
if ex([mCNN.TemName '_A'])
   % clear mCNN.Atem, global mCNN.Atem
   eval(['mCNN.Atem = ' mCNN.TemName '_A(:);']);

   % check r>2 
   if size(mCNN.Atem) == [25 1] mCNN.Nbr = 2; end       
   TemExists=1;
      
else FillAtem = 1; end

FillBtem = 0;
if ex([mCNN.TemName '_B'])
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

if ex([mCNN.TemName '_Aa']) 
   eval(['mCNN.At_n = ' mCNN.TemName '_Aa(:);']); TemExists=1; mCNN.TemType=1;   
   % check nonlin 
   extra_nonlin=1;
else mCNN.At_n=zeros(9,1); end  

if ex([mCNN.TemName '_a'])
   eval(['mCNN.nlin_a = ' mCNN.TemName '_a;']);
   % check nonlin 
   extra_nonlin=1;
else mCNN.nlin_a=[0 0]; end

if ex([mCNN.TemName '_Bb'])  
   eval(['mCNN.Bt_n = ' mCNN.TemName '_Bb(:);']); TemExists=1; mCNN.TemType=1;
   % check nonlin 
   extra_nonlin=1;
else mCNN.Bt_n=zeros(9,1); end   

if ex([mCNN.TemName '_b']) 
   eval(['mCNN.nlin_b = ' mCNN.TemName '_b;']);
   % check nonlin 
   extra_nonlin=1;
else mCNN.nlin_b=[0 0]; end

if ex([mCNN.TemName '_Dd'])  
   eval(['mCNN.Dt_n = ' mCNN.TemName '_Dd(:);']); TemExists=1; mCNN.TemType=2;
   % check nonlin 
   extra_nonlin=1;
else mCNN.Dt_n=zeros(9,1); end   

if ex([mCNN.TemName '_d']) 
   eval(['mCNN.nlin_d = ' mCNN.TemName '_d;']);
   % check nonlin 
   extra_nonlin=1;
else mCNN.nlin_d=[0 0]; end

% bias

if ex([mCNN.TemName '_I'])
   eval(['mCNN.I = ' mCNN.TemName '_I;']); TemExists=1; else mCNN.I=0; end      

% quit if the specified template does not ex(ist

if TemExists==0 error('The specified template does not exist!'); end


%check max tem values
tem_max_val=20; %set the max value allowed in templates
if max(abs([ mCNN.Atem(:)' mCNN.Btem(:)' mCNN.At_n(:)' mCNN.Bt_n(:)' mCNN.Dt_n(:)' mCNN.I(:)' ])) >20
    mCNN.Problems{end+1}=['Max allowed template walue is too high: ' num2str(max(abs([ mCNN.Atem(:)' mCNN.Btem(:)' mCNN.At_n(:)' mCNN.Bt_n(:)' mCNN.Dt_n(:)' mCNN.I(:)' ]))) ' in template: ' mCNN.TemName]
else
    if length(mCNN.nlin_a)>2
        if max(abs(mCNN.nlin_a(3:2:end-1)))>tem_max_val
            mCNN.Problems{end+1}=['Max allowed template walue is too high: ' num2str( max(abs(mCNN.nlin_a(3:2:end-1))) ) ' in template: ' mCNN.TemName];
        end
    else
        if length(mCNN.nlin_b)>2
            if max(abs(mCNN.nlin_b(3:2:end-1)))>tem_max_val
                mCNN.Problems{end+1}=['Max allowed template walue is too high: ' num2str( max(abs(mCNN.nlin_b(3:2:end-1))) ) ' in template: ' mCNN.TemName];
            end
        else
            if length(mCNN.nlin_d)>2
                if max(abs(mCNN.nlin_d(3:2:end-1)))>tem_max_val
                    mCNN.Problems{end+1}=['Max allowed template walue is too high: ' num2str( max(abs(mCNN.nlin_d(3:2:end-1))) ) ' in template: ' mCNN.TemName];
                end
            end    
        end
    end
end

%compute hardware complexity
if mCNN.Nbr == 2
    if extra_nonlin
        if mCNN.HWComplexity<4.5 mCNN.HWComplexity=4.5; end
    else
        if mCNN.HWComplexity<2.5 mCNN.HWComplexity=2.5; end
    end
else
    if extra_nonlin
        if mCNN.HWComplexity<1.5 mCNN.HWComplexity=1.5;  end
    end
end    

% return 
LT=mCNN.TemType;

function e=ex(field)
global mCNN;
eval(mCNN.TemGroup);
if (exist(field))
    e=1;
else
    pos=strfind(field,'.');
    if (size(pos,1))
        pos=pos(1);
        field=field(pos+1:size(field,2));
    end
    e=isfield(mCNN,field);
end