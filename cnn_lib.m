% ----------------------------------------
% Templates para uso pela toolbox MatCNN
% ----------------------------------------


% TEMPLATE TEXTUDIL (1)

TEXTUDIL_A = [0 0 0;
              0 0 0;
              0 0 0];
TEXTUDIL_B = [0 1 0;
              1 1 1;
              0 1 0];
TEXTUDIL_I = 3.8;



% TEMPLATE TEXTUDIL (2)
% Bom para imagens mais escuras, para obter ROIs maiores.

TEXTUDIL2_A = [0 0 0;
               0 0 0;
               0 0 0];
TEXTUDIL2_B = [0 1 0;
               1 1 1;
               0 1 0];
TEXTUDIL2_I = 3;


% % TEMPLATE BLUR
%
% BLUR_A = [0 1 0;
%           1 -4 1;
%           0 1 0];
% BLUR_B = [0.1 0.1 0.1;
%           0.1 0.2 0.1;
%           0.1 0.1 0.1];
% % BLUR_I = 1.0;
