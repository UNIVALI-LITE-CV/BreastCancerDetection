function main_03_SVM (total_de_imagens)
% total_de_imagens = n�mero de imagens da onde vieram os ROIs usados no SVM

% ----------------------------------------
% Acessando CSV com as caracter�sticas
% ----------------------------------------

[filename,pathname] = uigetfile('*.*');
if isequal(filename,0)
    return
end
disp(filename);
file = fullfile(pathname, filename);

% Transforma o CSV em uma tabela,
% sem a primeira coluna (cabe�alho)
% e sem a primeira linha (nome do arquivo)
tabela = readtable(file, ...
    'Delimiter', ';', 'ReadRowNames', true, 'ReadVariableNames', true);

% obt�m todas as colunas, menos a primeira
svm_X = table2array(tabela(:,(2:end)));

% obt�m somente a primeira coluna (classe)
svm_Y = table2array(tabela(:,1));

% ----------------------------------------
% Classificando o SVM
% ----------------------------------------

cp = classperf(svm_Y); % performance tracker

for repeticao = 1:10 % S� pra garantir que a m�dia dos resultados seja uniforme
    k = 10;
    cvFolds = crossvalind('Kfold', svm_Y, k);
    
    for i = 1:k                       % for each fold
        ids_teste = (cvFolds == i);   % Separa os �ndices das inst�ncias para teste
        ids_treinamento = ~ids_teste; % Separa os �ndices das inst�ncias para treinamento
        
        % Nota: No MatLab R2015a e vers�es posteriores,
        % a fun��o svmtrain foi substitu�da pela 'fitcsvm'
        
        % figure; % Caso ShowPlot = true
        % Treina o modelo SVM com as inst�ncias selecionadas para treinamento
        svmModel = svmtrain(svm_X(ids_treinamento,:), svm_Y(ids_treinamento), ...
            'ShowPlot', false, 'Kernel_Function','rbf', 'rbf_sigma',1, 'boxconstraint',1);
        
        % Testa o modelo usando as inst�ncias selecionadas para teste
        pred = svmclassify(svmModel, svm_X(ids_teste,:), 'Showplot', false);
        
        % Avalia a performance e atualiza o objeto que salva essas informa��es
        cp = classperf(cp, pred, ids_teste);
    end
    
end

% ----------------------------------------
% M�tricas dos Resultados
% ----------------------------------------

disp('------');

disp('Matriz de confus�o:');
% disp(cp.CountingMatrix);
disp(cp.DiagnosticTable/10);
% VP FP
% FN VN

disp('------');

% Dividido por 10 porque os testes s�o repetidos dez vezes
disp('FP/I:');
disp((cp.DiagnosticTable(1,2)/10)/total_de_imagens);
disp('FN/I:');
disp((cp.DiagnosticTable(2,1)/10)/total_de_imagens);

disp('Sensibilidade:');
disp(cp.Sensitivity);
disp('Especificidade:');
disp(cp.Specificity);
disp('Acur�cia:');
disp(cp.CorrectRate);

% Curva ROC (ou quase isso)
AUC = trapz([0 (1-cp.Specificity) 1], [0 cp.Sensitivity 1]);
disp('AUC:');
disp(AUC);

end