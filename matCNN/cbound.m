function [B] = cbound(A, v, r)

% CBOUND  Add a specified boundary to a CNN-type image
%
% function [B] = cbound(A, v, r)
%
% Inputs:
%  A - the input image
%  v - the mode specifier (scalar from [-1, 1] or 2, or 3)
%   	 [-1, 1]  - add a boundary to A with a constant value v
%       2       - add a zero-flux boundary to A duplicating the 
%                 outermost pixels of A
%       3       - then adds a torus boundary to A creating a torroidal 
%                 onnection between the boundary pixels of A
%  r - the boundary width (neighborhood constant)
%
% Output:
%  B - the generated image

%  $Id: cbound.m,v 1.3 2005/05/12 22:16:49 histvan Exp $
      
% check params

if (r<1 | r>24)
 error('r must be within the range [1, 24] !')
end

% add boundary

for i=1:fix(r)      % repeat r times                                           
                                            
 [S1, S2] = size(A);

 if (v>=-1 & v<=1)    % constant boundary

  B = [v*ones(S1,1) A v*ones(S1,1)];
  B = [v*ones(S2+2,1) B' v*ones(S2+2,1)]';
 
 elseif (v==2)       % zero-flux boundary

  B = [A(:,1) A A(:,S2)];
  B = [B(1,:)' B' B(S1, :)']';
 
 elseif (v==3)       % torus boundary

  B = [A(:,S2) A A(:,1)];
  B = [B(S1,:)' B' B(1, :)']';

 else error('The specified v value is not valid!'); 
 end
 
 if (i~=fix(r)) A = B; end
 
end  % for 

