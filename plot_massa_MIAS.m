function plot_massa_MIAS (I, pathname, nome, ROIs)

file = fullfile(pathname, 'info.txt');
info_file = fopen(file);

% Obt�m o primeiro registro referente a esta mamografia dispon�vel no arquivo.
% (CUIDADO: Caso haja mais de uma les�o, somente a primeira ser� obtida.)
linha = fgetl(info_file);
while ischar(linha)
    if ~isempty(strfind(linha, nome)) % Linha que possui o nome desta imagem
        break;
    end
    linha = fgetl(info_file);    
end
fclose(info_file);

% Extrai coordenadas do centro da les�o e o raio da sua circunfer�ncia 
x = str2num(linha(16:19));
y = str2num(linha(20:23));
r = str2num(linha(24:end));

x = (x/2) - 15; % Adapta coordenadas para condizer
y = (y/2) - 15; % com a vers�o da imagem sem bordas 
r = (r/2);      % e de tamanho reduzido

% Y precisa ser invertido
[altura,~] = size(I);
y = altura - y;

% Mostra a mamografia
figure; imshow(I, 'InitialMagnification', 'fit', 'Border', 'tight');
hold on;

% Desenha um ret�ngulo ao redor das les�es segmentadas
if exist('ROIs','var') == 1
    for i = 1:length(ROIs)
        struct = regionprops(ROIs{i}>0.1, ROIs{i}, 'BoundingBox');
        rectangle('Position',struct.BoundingBox,'EdgeColor','yellow');
    end
end

% Desenha circunfer�ncia da les�o real
circles(x,y,r,'edgecolor','r','facecolor','none');
hold off;

end

