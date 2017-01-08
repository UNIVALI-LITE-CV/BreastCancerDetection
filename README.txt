CONTATO: junkes@edu.univali.br
MAIS INFORMAÇÕES: https://goo.gl/SfKbEf

------------------------------------------------------------

ALGORITMO:

Código testado utilizando MATLAB R2013a

Etapa 1 (Pré-processamento):
Está dentro do arquivo "main_01.m"
Realiza a redução do tamanho das imagens, segmentação da região do seio e segmentação do músculo peitoral.

Etapa 2 (Segmentação de ROIs):
Está dentro do arquivo "main_01.m"
Realiza a segmentação das regiões de interesse através de Redes Neurais Celulares

Etapa 3 (Extração de Características):
Está dentro do arquivo "main_02.m"
Extrai, de cada ROI, os índices de Moran e Geary e a Função K de Ripley (no todo e para cada quantização da imagem)

Etapa 4 (Classificação):
Está dentro do arquivo "main_03_SVM.m"
Treina e executa um SVM com kernel gaussiano, com validação cruzada por 10-fold

------------------------------------------------------------

MAIN_01:

- Percorre uma pasta, examinando todas as imagens que ela contém.
- Depende do nome da imagem para determinar se ela é da MIAS ou da DDSM, e se ela é CC ou MLO.
- Necessita que o(s) arquivo(s) contendo as informações a respeito das lesões presentes esteja(m) situado(s) na mesma pasta. Algoritmo dá erro caso uma imagem não contenha lesões.
- Imagens salvas:

.ROIx =>   Cada ROI é salvo em uma imagem separada.
.seg01 =>  Região do seio segmentada.
.seg02 =>  (Somente MLO) Músculo segmentado.
.TEX =>    Imagem binária com o resultado do CNN
.check1 => Imagem original + demarcação da base (vermelho) + ROIs segmentados (amarelo)

------------------------------------------------------------

MAIN_02:

- Percorre uma pasta, examinando todas as imagens .ROIx que ela contém.
- Caso o algoritmo falhe com alguma imagem, ele apresentará uma mensagem de erro e prosseguirá para a próxima.
- O algoritmo percorre os ROIs por ordem de tamanho, já que é altamente provável que os ROIs maiores falhem por falta de memória no sistema.
- As características extraídas são armazenadas em um arquivo chamado "caracteristicas.csv" na pasta da onde o algoritmo está sendo rodado. Caso o arquivo já exista, resultados anteriores não são apagados.
- Por padrão, o algoritmo preenche a coluna "classe" com "normal". A avaliação de quais ROIs contêm lesões deve ser feita manualmente.

------------------------------------------------------------

MAIN_03_SVM:

- Algoritmo pede por um arquivo de características e o utiliza como input para um classificador SVM. Os resultados obtidos pelo classificador são impressos na tela.
