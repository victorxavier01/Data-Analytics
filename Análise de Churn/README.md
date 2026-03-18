# Sobre o Projeto
Este projeto visa identificar clientes com alta probabilidade de cancelar os seus serviços (Churn) numa empresa de telecomunicações. A solução integra Ciência de Dados para a modelação preditiva e Business Intelligence para a visualização estratégica, permitindo que a equipa de retenção tome decisões baseadas em dados.

## O Problema de Negócio
Reter um cliente atual é significativamente mais barato do que adquirir um novo. O objetivo é reduzir a taxa de evasão ao identificar padrões de comportamento que precedem o cancelamento, como o tipo de contrato, o método de pagamento e o valor das faturas.

## Tecnologias e Ferramentas
Linguagem: Python

Bibliotecas de ML: Scikit-Learn (Random Forest, Logistic Regression)

Manipulação e Visualização de Dados: Pandas, Numpy, Seaborn, Matplotlib

Business Intelligence: Power BI (DAX, Modelagem de Dados)

## Etapas do Desenvolvimento
1. Análise Exploratória e Limpeza (EDA)
Tratamento de valores nulos e conversão de tipos de dados (ex: TotalCharges).

Análise de correlação entre variáveis categóricas e o Churn.

Identificação de insights iniciais: Clientes com contratos mensais e fibra ótica apresentam maior risco.

2. Engenharia de Features e Modelagem
Transformação de variáveis categóricas utilizando LabelEncoder.

Escalonamento e tratamento de distribuições (log transform em MonthlyCharges).

Treino de modelos de classificação. O Random Forest foi o modelo final escolhido devido ao seu equilíbrio entre precisão e capacidade de identificar os principais preditores.

3. Integração com Power BI
Exportação dos resultados do modelo (probabilidades e previsões) para um ambiente de BI.

Criação de um Dashboard de Risco, categorizando os clientes em:

Risco Crítico: Probabilidade > 70%

Risco Médio: Probabilidade entre 40% e 70%

Risco Baixo: Probabilidade < 40%

## Principais Insights
Contratos: O modelo confirmou que contratos "Month-to-month" são os maiores geradores de churn.

Serviços: Clientes sem serviços de segurança online ou suporte técnico tendem a sair mais rapidamente.

Financeiro: Faturas mensais elevadas sem pacotes de fidelização aumentam o risco de evasão.