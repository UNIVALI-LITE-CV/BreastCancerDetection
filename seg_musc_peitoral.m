function I = seg_musc_peitoral (I)

[altura,largura] = size(I);

% ----------------------------------------
% Filtro de Canny
% ----------------------------------------

cannyImg = I(1:altura/2, 1:largura);

% Separa a parte de cima da imagem em duas metades
mediaEsquerda = mean2(cannyImg(1:altura/2, 1:largura/2));
mediaDireita = mean2(cannyImg(1:altura/2, largura/2:largura));

% O lado com a maior média de intensidade possui o músculo peitoral.
if mediaEsquerda > mediaDireita
    lado = 'esquerda';
    elemEstrut = strel('line',30,70);
else
    lado = 'direita';
    elemEstrut = strel('line',30,-70);
end
cannyImg = imopen(cannyImg,elemEstrut);
houghImg = edge(cannyImg,'canny');

% ----------------------------------------
% Transformada de Hough
% ----------------------------------------

[H,T,altMascara] = hough(houghImg);
P = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
% Encontra as linhas
lines = houghlines(houghImg,T,altMascara,P,'FillGap',5,'MinLength',7);
% figure, imshow(I, 'InitialMagnification', 'fit', 'Border', 'tight'), hold on;

tamanho_max = 0;
for k = 1:length(lines)
    xy = [lines(k).point1; lines(k).point2];
%     plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','yellow');
    
    % Plot beginnings and ends of lines
%     plot(xy(1,1),xy(1,2),'x','LineWidth',2,'Color','green');
%     plot(xy(2,1),xy(2,2),'x','LineWidth',2,'Color','red');
    
    % Determina o início e o fim da linha que for
    % a mais longa e estiver no ângulo correto (m positivo ou negativo).
    tamanho_linha = norm(lines(k).point1 - lines(k).point2);
    if (tamanho_linha > tamanho_max)
        % (Para evitar uma divisão por zero)
        if ((xy(2,1)-xy(1,1)) ~= 0)
            % Para descobrir o m em y = m*x + b,
            % calcula-se: m = (y2-y1)/(x2-x1)
            m = (xy(2,2)-xy(1,2))/(xy(2,1)-xy(1,1));

            % se o músculo estiver no lado direito, m precisa ser positivo.
            % se o músculo estiver no lado esquerdo, m precisa ser negativo.
            if (m > 0 && strcmp(lado,'direita') || m < 0 && strcmp(lado,'esquerda'))
                tamanho_max = tamanho_linha;
                maior_linha = xy;
            end
        end
    end
end

% Se a variável que identifica o músculo não existir
% (algoritmo falhou), retorna a imagem original.
if exist('maior_linha','var') == 0
    warning('Musc:unnableToSegment', ...
        '\n----------------------------------------\nNão foi possível segmentar o músculo peitoral.\n----------------------------------------');
    return
end

% Lembrete: se colocado em um gráfico, m deve ser invertido (tornado negativo,
% porque uma imagem é um gráfico invertido verticalmente.
% figure; fplot(@(x)-m*x+b, [0 10]);

% Calcula-se novamente o m da linha mais longa
m = (maior_linha(2,2)-maior_linha(1,2))/(maior_linha(2,1)-maior_linha(1,1));

% Calcula-se b com base em um par x,y já conhecido,
% através de b = -m*x + y
b = -m * maior_linha(1,1) + maior_linha(1,2);

linha_final = []; % linha = [[x1,y1],[x2,y2]]

% Adapta-se a fórmula (x = (y-b)/m) para encontrar o ponto que
% se conecta ao topo da imagem (y = 0):
linha_final(1,2) = 0;
linha_final(1,1) = (linha_final(1,2) - b)/m;

if strcmp(lado,'esquerda')
    % Caso o músculo esteja à esquerda,
    % procura-se o ponto que se conecta com a esquerda da imagem (x = 0):
    linha_final(2,1) = 0;
    linha_final(2,2) = m * linha_final(2,1) + b;
else
    % Caso o músculo esteja à direita,
    % procura-se o ponto que se conecta com a direita da imagem (x = largura):
    linha_final(2,1) = largura;
    linha_final(2,2) = m * linha_final(2,1) + b;
end

% figure, imshow(I, 'InitialMagnification', 'fit', 'Border', 'tight'), hold on;
% plot(linha_final(:,1),linha_final(:,2),'LineWidth',2,'Color','magenta');
% plot(maior_linha(:,1),maior_linha(:,2),'LineWidth',3,'Color','cyan');
% hold off;

% ----------------------------------------
% Aplicação da máscara
% ----------------------------------------

if strcmp(lado,'esquerda')
    rows    = [linha_final(2,1) linha_final(1,1) largura largura    0  ];
    columns = [linha_final(2,2) linha_final(1,2)    0    altura  altura];
else % lado == 'direita'
    rows    = [0 linha_final(1,1) linha_final(2,1) largura    0  ];
    columns = [0 linha_final(1,2) linha_final(2,2) altura  altura];
end

mascara = roipoly(I,rows,columns);

% deleta da imagem original os pixels que são pretos na máscara
for x = 1:altura
    for y = 1:largura
        if mascara(x,y) == 0 % branco
            I(x,y) = 0;
        end
    end
end

figure, imshow(I, 'InitialMagnification', 'fit', 'Border', 'tight');

end