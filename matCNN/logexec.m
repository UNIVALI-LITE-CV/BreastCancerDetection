function RES = logexec(LType, OPER1, OPER2, disp_fl)

% LOGEXEC  Execute the specified logic operation on CNN images
%
% function RES = logexec(LType, OPER1, OPER2, disp_fl)
%
% Inputs:
%
% Output:

% $Id: logexec.m,v 1.6 2005/05/12 22:16:49 histvan Exp $
 
% declare global variables of the CNN environment

global mCNN
    
% check input-output params
if nargin < 4 disp_fl = 0; end    
         
% quit if the CNN environment is not loaded

if exist('mCNN')~=1 error('The CNN environment is not loaded!'); end

% execute logical operation (force binary)

if strcmp(LType, 'and')   
 RES = 2*double(and(grayslice(OPER1,1e-10),grayslice(OPER2,1e-10)))-1;
elseif strcmp(LType, 'not1and')   
 RES = 2*double(and(not(grayslice(OPER1,1e-10)),grayslice(OPER2,1e-10)))-1;
elseif strcmp(LType, 'or')     
 RES = 2*double(or(grayslice(OPER1,1e-10),grayslice(OPER2,1e-10)))-1;
elseif strcmp(LType, 'not1or')     
 RES = 2*double(or(not(grayslice(OPER1,1e-10)),grayslice(OPER2,1e-10)))-1;
elseif strcmp(LType, 'xor')   
 RES = 2*double(xor(grayslice(OPER1,1e-10),grayslice(OPER2,1e-10)))-1;
elseif strcmp(LType, 'not')   
 RES = 2*double(not(grayslice(OPER1,1e-10)))-1;
else
 warning('Wrong logic function specified!')   
end

if disp_fl figure, cnnshow(RES); pause, close(gcf), end
