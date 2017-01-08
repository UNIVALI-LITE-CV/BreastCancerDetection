function [resultMap, RipleysL] = funcao_ripley (I)

I = im2uint8(I);
[altura, largura] = size(I);

% ----------------------------------------
% K de cada nível de cinza
% ----------------------------------------

resultMap = containers.Map();

inicio = 16;
steps = 32;

for bits = 3:8
    disp(strcat('Ripley (',int2str(bits),' bits)...'));
    % Quantização da imagem
    imagem_quant = change_bit_depth(I,bits);
    
    % Para cada nível de cinza
    for intensidade = inicio:steps:255
        esta_camada = imagem_quant == intensidade;
        
        % Monta vetores de coordenadas
        vetor_X = [];
        vetor_Y = [];
        
        for x = 1:altura
            for y = 1:largura
                if esta_camada(x,y) ~= 0
                    vetor_X(end+1) = x;
                    vetor_Y(end+1) = y;
                end
            end
        end
        
        if sum(sum(esta_camada)) == 0 % Não há pixels com esta intensidade
            resultMap( strcat('k_',int2str(bits),'bits_',int2str(intensidade)) ) = -999;
        else
            locs = [transpose(vetor_X) transpose(vetor_Y)]; % Coordenadas
            dist = (floor(largura/2)); % Distância: raio da imagem
            box = [1 largura 1 largura]; % Bounding box
            
            [~,L] = ripley_colorado(locs,dist,box);
            resultMap( strcat('k_',int2str(bits),'bits_',int2str(intensidade)) ) = L;
        end
    end
    inicio = ceil(inicio/2);
    steps = ceil(steps/2);
end

% ----------------------------------------
% K da imagem inteira
% ----------------------------------------

vetor_X = [];
vetor_Y = [];

for x = 1:altura
    for y = 1:largura
        if I(x,y) ~= 0
            vetor_X(end+1) = x;
            vetor_Y(end+1) = y;
        end
    end
end

locs = [transpose(vetor_X) transpose(vetor_Y)]; % Coordenadas
dist = (floor(largura/2)); % Distância: raio da imagem
box = [1 largura 1 largura]; % Bounding box

[~, RipleysL] = ripley_colorado(locs,dist,box);

end