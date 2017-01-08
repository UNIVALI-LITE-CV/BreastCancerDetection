function [I] = seg_regiao_seio(I)

[altura,largura] = size(I);

% ----------------------------------------
% Limiariza��o da imagem
% ----------------------------------------

I = imadjust(I);  % Pretos == 0; Brancos == 255;
I = im2double(I); % Pretos == 0; Brancos == 1;
imgOriginal = I;

% Limiariza��o / cria��o da m�scara inicial:
% Uma matriz l�gica � criada onde os pixels mais claros (>0.07) s�o 1
% e o resto � deixado preto (0).
I = I > 0.07;

% ----------------------------------------
% Eros�o + Dilata��o (Abertura)
% ----------------------------------------

elemEstrut = strel('disk',10);
I = imopen(I,elemEstrut);
% figure, imshow(I, 'InitialMagnification', 'fit', 'Border', 'tight');

% ----------------------------------------
% Algoritmo de crescimento de regi�o
% ----------------------------------------

% I = im2double(I); % Pretos == 0; Brancos == 1;
regiao = double.empty(0,0);
pixelCount = 0; % N�mero de pixels que a regi�o/m�scara atual cont�m.

%for each pixel
for x = 1:altura
    for y = 1:largura
        % Somente pixels brancos:
        if I(x,y) == 1
            % Se a regi�o/m�scara estiver vazia...
            if isempty(regiao)
                % forma a primeira regi�o.
                regiao = regiongrowing(I,x,y,0.5);
                pixelCount = sum(sum(regiao == 1));
            % Se houver uma regi�o/m�scara atual...
            else
                % e o pixel n�o pertencer a ela...
                % (ou seja, o pixel relativo a este na regi�o for preto)
                if regiao(x,y) == 0
                    % forma uma nova regi�o.
                    novaRegiao = regiongrowing(I,x,y,0.5);
                    novoPixelCount = sum(sum(novaRegiao == 1));
                    % Se a nova regi�o for maior (possuir mais pixels),
                    if novoPixelCount > pixelCount
                        % remove da imagem a regi�o anterior
                        I = (I-regiao);
                        % e substitui a regi�o candidata a 'regi�o do seio'.
                        regiao = novaRegiao;
                        pixelCount = novoPixelCount;
                    else
                        % Sen�o, remove a nova regi�o da imagem.
                        I = (I-novaRegiao);
                    end
                end
            end
        end
    end
end
% figure, imshow(I);

% ----------------------------------------
% Aplica��o da m�scara
% ----------------------------------------

% Convers�o de matriz l�gica de volta para double
I = im2double(I);
% Substitui��o dos pixels brancos (1) da m�scara pelo seu valor original
I = I.*imgOriginal;

% Aparo da imagem:
% Elimina todas as colunas que n�o possuam nada al�m de pixels pretos
% I(:,~any(I)) = [];

end