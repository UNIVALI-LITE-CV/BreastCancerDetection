function I = reducao_imagem (I)

[altura,~] = size(I);

if (altura > 1024) % imagens da DDSM são reduzidas a 1/8 do seu tamanho
    I = imresize(I, 0.125);
else               % imagens da MIAS são reduzidas a 1/2 do seu tamanho
    I = imresize(I, 0.5);
end

[altura,largura] = size(I);
I = I(16:altura-15, 16:largura-15); % remove bordas (15 pixels de cada lado)
% Resultado: Imagem com cerca de 500 pixels de altura


end

