function plot_massa_DDSM_2 (chain)

% Remove o marcador de fim de chain code (' #')
chain = chain(1:end-2);

% Passa a string para um vetor de inteiros
chain_code = strread(chain);

% Obt�m coordenadas do ponto de in�cio
vetor_X = chain_code(1);
vetor_Y = chain_code(2);

% Remove as coordenadas do ponto de in�cio
chain_code = chain_code(3:end);

% Interpreta chain code, conforme:
% http://marathon.csee.usf.edu/Mammography/DDSM/case_description.html#OVERLAYFILE
for i = chain_code
    switch i
        case 0
            novo_X = vetor_X(end);
            novo_Y = vetor_Y(end) - 1;
        case 1
            novo_X = vetor_X(end) + 1;
            novo_Y = vetor_Y(end) - 1;
        case 2
            novo_X = vetor_X(end) + 1;
            novo_Y = vetor_Y(end);
        case 3
            novo_X = vetor_X(end) + 1;
            novo_Y = vetor_Y(end) + 1;
        case 4
            novo_X = vetor_X(end);
            novo_Y = vetor_Y(end) + 1;
        case 5
            novo_X = vetor_X(end) - 1;
            novo_Y = vetor_Y(end) + 1;
        case 6
            novo_X = vetor_X(end) - 1;
            novo_Y = vetor_Y(end);
        case 7
            novo_X = vetor_X(end) - 1;
            novo_Y = vetor_Y(end) - 1;
    end
    vetor_X(end+1) = novo_X;
    vetor_Y(end+1) = novo_Y;
end

vetor_X = (vetor_X/8) - 15; % Adapta dimens�es da les�o para condizer com a
vetor_Y = (vetor_Y/8) - 15; % vers�o de tamanho reduzido e sem bordas da imagem

% Desenha per�metro da les�o real
plot(vetor_X, vetor_Y, 'Color', 'r');

end