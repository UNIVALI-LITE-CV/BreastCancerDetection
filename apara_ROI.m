function novaImagem = apara_ROI (imagemInteira)

% Calcula dimensões do ROI
struct = regionprops(imagemInteira > 0.1, imagemInteira, 'BoundingBox');

% figure; imagesc(imagemInteira); colormap gray; axis image; hold on; 
% rectangle('Position',struct.BoundingBox,'EdgeColor','yellow'); hold off;

% Para garantir que as dimensões do ROI
% não ultrapassarão as dimensões da imagem inteira.
[altura, largura] = size(imagemInteira);
BB = floor(struct.BoundingBox);
x2 = BB(1)+BB(3);
y2 = BB(2)+BB(4);
if x2 > largura
    x2 = largura;
end
if y2 > altura
    y2 = altura;
end

% Retorna o ROI recortado a partir da imagem inteira
novaImagem = imagemInteira( struct.BoundingBox(2):y2, ...
    struct.BoundingBox(1):x2 );

end

