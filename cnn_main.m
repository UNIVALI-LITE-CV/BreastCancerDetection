function ROIs = cnn_main(imagemOriginal, template)

tam = size(imagemOriginal);
% A função que transformaria a imagem de entrada para as especificações
% utilizadas pelo algoritmo ('gray2cnn.m') não funciona nas versões atuais
% do MatLab. Mas, seria isto que ela faria para uma imagem em double:
imagemCNN = -2*double(imagemOriginal)/1+ones(tam);

% ----------------------------------------
% CNN: TEXTUDIL
% ----------------------------------------

cnn_setenv;                % Inicia as variáveis do ambiente CNN
mCNN.TemGroup = 'cnn_lib'; % Adiciona biblioteca de templates

mCNN.INPUT1 = imagemCNN;   % Entrada da rede: imagem original
mCNN.STATE = imagemCNN;    % Estado inicial da rede: idem
% UseBiasMap = 1;
% UseMask = 1;

% Para encerrar a simulação quando as células se estabilizarem
mCNN.Boundary = 2;

loadtem(template);   % Carrega o template
mCNN.TimeStep = 0.2; % Tempo entre passos/iterações
mCNN.IterNum = 25;   % Número de passos
runtem;              % Roda a simulação

% Inverte a imagem
resultadoCNN = -(mCNN.OUTPUT);

% ----------------------------------------
% 1.2. Dilatação + Erosão (Fechamento)
% ----------------------------------------

% Limiarização / criação da máscara inicial:
% Uma matriz lógica é criada onde os pixels claros (>0.05) são 1
% e o resto é deixado preto (0).
figure; imshow(resultadoCNN);
resultadoCNN = resultadoCNN > 0.05;
% figure; imshow(resultadoCNN);

elemEstrut = strel('octagon',3);
resultadoCNN = imclose(resultadoCNN,elemEstrut);
% figure; imshow(resultadoCNN);

% ----------------------------------------
% Extração por crescimento de região
% ----------------------------------------

[altura, largura] = size(resultadoCNN);
mascaraCompleta = zeros(altura, largura, 'double');
mascaraFinal = zeros(altura, largura, 'double');

num = 0; % Inicalização do número de resultados
ROIs = {};

%for each pixel
for x = 1:altura
    for y = 1:largura
        % Somente pixels brancos:
        if resultadoCNN(x,y) == 1
            % forma uma nova região.
            novaRegiao = regiongrowing(resultadoCNN,x,y,0.999);
            pixelCount = sum(sum(novaRegiao == 1));
            % Se a nova região for maior que o limite mínimo,
            mascaraCompleta = mascaraCompleta+novaRegiao;
            if pixelCount > 600
                num = num + 1;
                % Adiciona a nova região à máscara resultante
                mascaraFinal = mascaraFinal+novaRegiao;
                % Aplica máscara e obtém a região segmentada
                ROIs{num} = novaRegiao.*imagemOriginal;
            end
            % Remove a nova região da imagem.
            resultadoCNN = (resultadoCNN-novaRegiao);
        end
    end
end
figure; imshow(mascaraCompleta);
figure, imshow(mascaraFinal);

end