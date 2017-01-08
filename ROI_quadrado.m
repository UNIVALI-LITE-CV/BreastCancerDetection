function ROI = ROI_quadrado (ROI)

% ----------------------------------------
% Torna uma imagem quadrada
% ----------------------------------------

[altura, largura] = size(ROI);
maior_dimensao = max(altura, largura);

% Calcula o quanto falta para a altura ou a largura
% se igualarem à maior dimensão da imagem
falta_altura = maior_dimensao-altura;
falta_altura = floor(falta_altura/2);
falta_largura = maior_dimensao-largura;
falta_largura = floor(falta_largura/2);

% Preenche a matriz até ela ficar quadrada
ROI = padarray(ROI, [falta_altura falta_largura]);

end

