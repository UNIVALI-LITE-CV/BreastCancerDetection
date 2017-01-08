function [MoransI, GearysC] = indices_moran_geary (imagem)
% imagem = im2double(imread('teste.png'));

% ----------------------------------------
% Construção da matriz de pesos
% ----------------------------------------

X = imagem(:); % Imagem transformada em um vetor
size_squared = length(X); % (largura * altura) da imagem original
try
    matriz_de_pesos = zeros(size_squared, size_squared, 'double');
catch
    warning('MoranGeary:OutOfMemory', ...
        '\n----------------------------------------\nOut of Memory Error\n----------------------------------------');
end
[altura, largura] = size(imagem);

k = 1;
for j=1:largura,
    for i=1:altura,
        if (i > 1)
            matriz_de_pesos(k,sub2ind(size(imagem), i-1, j)) = 1; % i - 1
        end
        if (i < altura)
            matriz_de_pesos(k,sub2ind(size(imagem), i+1, j)) = 1; % i + 1
        end
        if (j > 1)
            matriz_de_pesos(k,sub2ind(size(imagem), i, j-1)) = 1; % j - 1
        end
        if (j < largura)
            matriz_de_pesos(k,sub2ind(size(imagem), i, j+1)) = 1; % j + 1
        end
        k = k+1;
    end
end

% Normalização da matriz de forma que a soma
% de todos os seus coeficientes seja igual a 1
matriz_de_pesos = matriz_de_pesos / sum(abs(matriz_de_pesos(:)));

% ----------------------------------------
% Cálculo dos Índices de Moran e Geary
% ----------------------------------------

% Inicialização das variáveis
numeradorMoran = 0;
numeradorGeary = 0;
denominador = 0; % Utilizado por ambas as equações
W = 0; % Para a soma de todos os coeficientes  de peso da matriz
N = size(X,1);
media_X = mean(X);

% Cálculo dos índices
for i=1:N,
    for j=1:N,
        % Desconsidera-se a diagonal principal da matriz
        if (matriz_de_pesos(i,j) ~= 0)

            % para Moran
            numeradorMoran = numeradorMoran + ...
                matriz_de_pesos(i,j)*((X(i)-media_X)*(X(j)-media_X));
            
            % para Geary
            W = W + matriz_de_pesos(i,j);
            numeradorGeary = numeradorGeary + ...
                matriz_de_pesos(i,j)*((X(i)-X(j))^2);
        end
    end
    % para ambos
    denominador = denominador + (X(i)-media_X)^2;
end

% Índice Global de Moran (Moran's I)
MoransI = (N/W)*(numeradorMoran/denominador);

% Índice de Geary (Geary's C)
GearysC = ((N-1)*numeradorGeary)/(2*W*denominador);

end

% Cálculo do Índice de Moran através da toolbox Fathom:
% MC = f_moran(vetor_imagem, matriz_de_pesos)
