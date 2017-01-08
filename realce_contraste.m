function new_I = realce_contraste (I)

% Obt�m o menor elemento da matriz
% (o preto do fundo)
menor = min( I(:) );

% Obt�m o segundo menor elemento da matriz
% (o cinza mais escuro da regi�o do seio)
seg_menor = min( I(I>min( I(:) )) );

[altura,largura] = size(I);
new_I = I;
% O maior valor (preto) recebe um valor levemente maior
% que o segundo menor valor (cinza escuro)
for x = 1:altura
    for y = 1:largura
        if I(x,y)== menor
            new_I(x,y) = seg_menor + 0.001;
        end
    end
end

% Alonga linearmente o histograma
new_I = imadjust(new_I);

end

