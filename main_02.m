function main_02_batch

% Adiciona caminhos para as subpastas
addpath(genpath('..\'),'-end');

% ----------------------------------------
% Acessa pasta contendo as imagens
% ----------------------------------------

pathname = uigetdir();
listing = dir(pathname);
listing = nestedSortStruct(listing,'bytes');
num_Files = length(listing);

for k = 1:num_Files
    [~,filename,extensao] = fileparts(listing(k).name);
    if strcmp(extensao,'.png') && ~isempty(strfind(filename, 'ROI'))
        filename = listing(k).name;
        try
            
            % ----------------------------------------
            % Obtém ROI do arquivo
            % ----------------------------------------
            
            % Carrega a imagem
            ROI = im2double(imread(fullfile(pathname, filename)));
            
            % Determina a raiz do nome do arquivo
            if (strcmp(filename(1:3),'mdb'))
                nome = filename(1:6); % MIAS (ex.: 'mdb001')
            else
                nome = filename(1:end-4); % DDSM (remove '.ROIx')
            end
            
            disp( strcat('(',int2str(k),'/',int2str(num_Files), ...
                ') Processando arquivo (', int2str(listing(k).bytes), ...
                ' bytes) "', nome, '"' ) );
            
            % ----------------------------------------
            % Extração de características (Textura)
            % ----------------------------------------
            
            extracao_caracteristicas(ROI, nome);
            
        catch
            warning('Algoritmo:error', ...
                '\n----------------------------------------\nO algoritmo encontrou um erro.\n----------------------------------------');
        end
    end
end

end
