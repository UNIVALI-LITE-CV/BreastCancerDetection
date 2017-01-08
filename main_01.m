function main_01_batch

% Adiciona caminhos para as subpastas
addpath(genpath('..\'),'-end');

% ----------------------------------------
% Acessa pasta contendo as imagens
% ----------------------------------------

pathname = uigetdir();
listing = dir(pathname);
num_Files = length(listing);

for k = 1:num_Files
    [~,~,extensao] = fileparts(listing(k).name);
    if strcmp(extensao,'.pgm') || strcmp(extensao,'.tif')
        filename = listing(k).name;
        
        % ----------------------------------------
        % Obtém imagem do arquivo
        % ----------------------------------------
        
        I = imread(fullfile(pathname, filename));
        
        % Determina a raíz do nome do arquivo
        if (strcmp(filename(1:3),'mdb'))
            nome = filename(1:end-4); % MIAS (remove '.pgm')
        else
            nome = filename(1:end-18); % DDSM (remove '.LJPEG.1.image.tif')
        end
        
        disp( strcat('(',int2str(k),'/',int2str(num_Files),') Processando arquivo:  ', nome) );
        
        % ----------------------------------------
        % Redução do tamanho da imagem
        % ----------------------------------------
        
        % (Também remove 15 pixels de cada borda)
        I = reducao_imagem(I); % Imagem com cerca de 500 pixels de altura
        imgReduzida = I; % Salva uma cópia do estado reduzido da imagem
        
        % ----------------------------------------
        % Segmentação da região do seio
        % ----------------------------------------
        
        I = seg_regiao_seio(I);
        imwrite(I,fullfile(pathname, strcat(nome,'.seg01.png')),'Transparency',0);
        
        % ----------------------------------------
        % Segmentação do músculo peitoral
        % ----------------------------------------
        
        % Executa somente se a mamografia for
        % uma MLO da DDSM ou um arquivo da MIAS
        if (~isempty(strfind(filename, 'MLO')) || strcmp(filename(1:3),'mdb'))
            I = seg_musc_peitoral(I);
        end
        
        I = realce_contraste(I);
        
        if (~isempty(strfind(filename, 'MLO')) || strcmp(filename(1:3),'mdb'))
            imwrite(I,fullfile(pathname, strcat(nome,'.seg02.png')),'Transparency',0);
        end
        
        % ----------------------------------------
        % Segmentação de ROIs (CNN, Template TEXTUDIL)
        % ----------------------------------------
        
        resultadosCNN = {};
        % Algoritmo de Redes Neurais Celulares
        resultadosCNN = cnn_main(I,'TEXTUDIL');
        
        print(fullfile(pathname, strcat(nome,'.TEX.png')),'-dpng');
        
        % Salva cada ROI separadamente para
        % utilização posterior (main_02_ext_carac)
        num1 = length(resultadosCNN);
        for i = 1:num1
            ROI = apara_ROI(resultadosCNN{i});
            imwrite( ROI, fullfile(pathname, ...
                strcat(strcat(strcat(nome,'.ROI'),int2str(i)),'.png')) );
        end
        
        % ----------------------------------------
        % Apresentação dos resultados
        % ----------------------------------------
        
        % Ilustração do verdadeiro perímetro da lesão
        if strcmp(nome(1:3),'mdb') % if MIAS
            plot_massa_MIAS(imgReduzida,pathname,nome,resultadosCNN);
        else                       % if DDSM
            plot_massa_DDSM(imgReduzida,pathname,nome,resultadosCNN);
        end
        
        print(fullfile(pathname, strcat(nome,'.check.png')),'-dpng');
        
        close all % Fecha janelas abertas
        
    end
end

end
