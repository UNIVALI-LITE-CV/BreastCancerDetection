function plot_massa_DDSM (I, pathname, nome, ROIs)

% % Pede pelo arquivo Overlay
% [filename,pathname] = uigetfile('*.OVERLAY');
% if isequal(filename,0)
%     return
% end
% file = fullfile(pathname, filename);

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

file = fullfile(pathname, strcat(nome,'.OVERLAY'));
overlay = fopen(file);

% Mamografia n�o possui les�o
if overlay == -1
    return;
end

% Obt�m o primeiro chain code dispon�vel no arquivo.
linha = fgetl(overlay);
while ischar(linha)
    linha = fgetl(overlay);
    if strcmp(linha,'BOUNDARY') || strcmp(linha,'	CORE')
        
        chain = fgetl(overlay);
        
        % Interpreta chain code
        plot_massa_DDSM_2(chain);
        
    end
end
fclose(overlay);

hold off;
end