function extracao_caracteristicas (I, nome)

% ----------------------------------------
% Cálculo dos Índices de Moran e Geary
% ----------------------------------------

disp('Calculando Moran/Geary...');
[MoransI, GearysC] = indices_moran_geary(I);

% ----------------------------------------
% Cálculo da Função K de Ripley
% ----------------------------------------

disp('Calculando Ripley...');
[RipleyResultMap, Ripley] = funcao_ripley(I);

% ----------------------------------------
% Armazenando valores em um arquivo CSV
% ----------------------------------------

file = fopen('caracteristicas.csv', 'a');
% Garante que o arquivo será fechado mesmo que aconteça um erro
c = onCleanup(@()fclose(file));

% Se o arquivo estiver vazio, escreve cabeçalho
if fseek(file, 1, 'bof') == -1
    
    string_ripley = '';
    inicio = 16;
    steps = 32;
    for bits = 3:8
        for intensidade = inicio:steps:255
            string_ripley = strcat( string_ripley, ...
                ';k_',int2str(bits),'bits_',int2str(intensidade) );
        end
        inicio = ceil(inicio/2);
        steps = ceil(steps/2);
    end
    
    fprintf(file,'%s',strcat('nome_da_imagem;classificacao;moran;geary;ripley', ...
        string_ripley));
end

fprintf(file,'\r\n');
fprintf(file,'%s;',nome);
fprintf(file,'%s;','normal');
fprintf(file,'%.4g;',MoransI);
fprintf(file,'%.4g;',GearysC);
fprintf(file,'%.4g',Ripley);

inicio = 16;
steps = 32;
for bits = 3:8
    for intensidade = inicio:steps:255
        fprintf( file,';%.4g', ...
            RipleyResultMap( strcat('k_',int2str(bits),'bits_',int2str(intensidade)) ) );
    end
    inicio = ceil(inicio/2);
    steps = ceil(steps/2);
end

end
