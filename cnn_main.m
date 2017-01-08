function ROIs = cnn_main(imagemOriginal, template)

tam = size(imagemOriginal);
% A fun��o que transformaria a imagem de entrada para as especifica��es
% utilizadas pelo algoritmo ('gray2cnn.m') n�o funciona nas vers�es atuais
% do MatLab. Mas, seria isto que ela faria para uma imagem em double:
imagemCNN = -2*double(imagemOriginal)/1+ones(tam);

% ----------------------------------------
% CNN: TEXTUDIL
% ----------------------------------------

cnn_setenv;                % Inicia as vari�veis do ambiente CNN
mCNN.TemGroup = 'cnn_lib'; % Adiciona biblioteca de templates

mCNN.INPUT1 = imagemCNN;   % Entrada da rede: imagem original
mCNN.STATE = imagemCNN;    % Estado inicial da rede: idem
% UseBiasMap = 1;
% UseMask = 1;

% Para encerrar a simula��o quando as c�lulas se estabilizarem
mCNN.Boundary = 2;

loadtem(template);   % Carrega o template
mCNN.TimeStep = 0.2; % Tempo entre passos/itera��es
mCNN.IterNum = 25;   % N�mero de passos
runtem;              % Roda a simula��o

% Inverte a imagem
resultadoCNN = -(mCNN.OUTPUT);

% ----------------------------------------
% 1.2. Dilata��o + Eros�o (Fechamento)
% ----------------------------------------

% Limiariza��o / cria��o da m�scara inicial:
% Uma matriz l�gica � criada onde os pixels claros (>0.05) s�o 1
% e o resto � deixado preto (0).
figure; imshow(resultadoCNN);
resultadoCNN = resultadoCNN > 0.05;
% figure; imshow(resultadoCNN);

elemEstrut = strel('octagon',3);
resultadoCNN = imclose(resultadoCNN,elemEstrut);
% figure; imshow(resultadoCNN);

% ----------------------------------------
% Extra��o por crescimento de regi�o
% ----------------------------------------

[altura, largura] = size(resultadoCNN);
mascaraCompleta = zeros(altura, largura, 'double');
mascaraFinal = zeros(altura, largura, 'double');

num = 0; % Inicaliza��o do n�mero de resultados
ROIs = {};

%for each pixel
for x = 1:altura
    for y = 1:largura
        % Somente pixels brancos:
        if resultadoCNN(x,y) == 1
            % forma uma nova regi�o.
            novaRegiao = regiongrowing(resultadoCNN,x,y,0.999);
            pixelCount = sum(sum(novaRegiao == 1));
            % Se a nova regi�o for maior que o limite m�nimo,
            mascaraCompleta = mascaraCompleta+novaRegiao;
            if pixelCount > 600
                num = num + 1;
                % Adiciona a nova regi�o � m�scara resultante
                mascaraFinal = mascaraFinal+novaRegiao;
                % Aplica m�scara e obt�m a regi�o segmentada
                ROIs{num} = novaRegiao.*imagemOriginal;
            end
            % Remove a nova regi�o da imagem.
            resultadoCNN = (resultadoCNN-novaRegiao);
        end
    end
end
figure; imshow(mascaraCompleta);
figure, imshow(mascaraFinal);

end