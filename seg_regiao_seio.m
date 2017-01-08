function [I] = seg_regiao_seio(I)

[altura,largura] = size(I);

% ----------------------------------------
% Limiarização da imagem
% ----------------------------------------

I = imadjust(I);  % Pretos == 0; Brancos == 255;
I = im2double(I); % Pretos == 0; Brancos == 1;
imgOriginal = I;

% Limiarização / criação da máscara inicial:
% Uma matriz lógica é criada onde os pixels mais claros (>0.07) são 1
% e o resto é deixado preto (0).
I = I > 0.07;

% ----------------------------------------
% Erosão + Dilatação (Abertura)
% ----------------------------------------

elemEstrut = strel('disk',10);
I = imopen(I,elemEstrut);
% figure, imshow(I, 'InitialMagnification', 'fit', 'Border', 'tight');

% ----------------------------------------
% Algoritmo de crescimento de região
% ----------------------------------------

% I = im2double(I); % Pretos == 0; Brancos == 1;
regiao = double.empty(0,0);
pixelCount = 0; % Número de pixels que a região/máscara atual contém.

%for each pixel
for x = 1:altura
    for y = 1:largura
        % Somente pixels brancos:
        if I(x,y) == 1
            % Se a região/máscara estiver vazia...
            if isempty(regiao)
                % forma a primeira região.
                regiao = regiongrowing(I,x,y,0.5);
                pixelCount = sum(sum(regiao == 1));
            % Se houver uma região/máscara atual...
            else
                % e o pixel não pertencer a ela...
                % (ou seja, o pixel relativo a este na região for preto)
                if regiao(x,y) == 0
                    % forma uma nova região.
                    novaRegiao = regiongrowing(I,x,y,0.5);
                    novoPixelCount = sum(sum(novaRegiao == 1));
                    % Se a nova região for maior (possuir mais pixels),
                    if novoPixelCount > pixelCount
                        % remove da imagem a região anterior
                        I = (I-regiao);
                        % e substitui a região candidata a 'região do seio'.
                        regiao = novaRegiao;
                        pixelCount = novoPixelCount;
                    else
                        % Senão, remove a nova região da imagem.
                        I = (I-novaRegiao);
                    end
                end
            end
        end
    end
end
% figure, imshow(I);

% ----------------------------------------
% Aplicação da máscara
% ----------------------------------------

% Conversão de matriz lógica de volta para double
I = im2double(I);
% Substituição dos pixels brancos (1) da máscara pelo seu valor original
I = I.*imgOriginal;

% Aparo da imagem:
% Elimina todas as colunas que não possuam nada além de pixels pretos
% I(:,~any(I)) = [];

end