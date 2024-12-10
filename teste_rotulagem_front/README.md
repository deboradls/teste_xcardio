# 🩺 Projeto de Automação de Testes - XCardio
Este projeto foi desenvolvido para automatizar os testes do sistema de **ROTULAGEM** do **XCardio**, como parte de uma iniciativa do **Laboratório de Sistemas e Inteligência Computacional (LASIC)**, coordenado pelo professor **Henrique Leitão**.

A automação utiliza o **Robot Framework** com a **SeleniumLibrary** para interagir com a interface web, realizando tarefas como marcação automática de checkboxes, seleção de opções em dropdowns e submissão de formulários.

## 📑 Índice
- [🩺 Projeto de Automação de Testes - XCardio](#-projeto-de-automação-de-testes---xcardio)
  - [📑 Índice](#-índice)
  - [🛠️ Requisitos](#️-requisitos)
  - [📥 Instalação das dependências](#-instalação-das-dependências)
    - [🐍 1. Instalar Python](#-1-instalar-python)
    - [🤖 2. Instalar Robot Framework e SeleniumLibrary](#-2-instalar-robot-framework-e-seleniumlibrary)
    - [🌐 3. Baixar e Configurar o Browser Driver](#-3-baixar-e-configurar-o-browser-driver)
  - [📝 Estrutura do Projeto](#-estrutura-do-projeto)
  - [⚙️ Configuração](#️-configuração)
  - [📂 Estrutura do Arquivo de Teste](#-estrutura-do-arquivo-de-teste)
  - [🚀 Execução](#-execução)

## 🛠️ Requisitos
- **Python 3.x**
- **Robot Framework**
- **SeleniumLibrary**
- **Browser driver** (Ex: [Geckodriver](https://github.com/mozilla/geckodriver) para Firefox)

## 📥 Instalação das dependências
Se ainda não tem os requisitos, veja como instalar:

### 🐍 1. Instalar Python
- **Baixar e Instalar**: Vá para a [página de downloads do Python](https://www.python.org/downloads/) e baixe a versão 3.x. Marque "Add Python to PATH" durante a instalação.
- **Verificar**: No terminal, digite:
  ```bash
  python --version
  ```
  
### 🤖 2. Instalar Robot Framework e SeleniumLibrary

- **No Terminal**:
  ```bash
  pip install robotframework
  pip install robotframework-seleniumlibrary
  ```

### 🌐 3. Baixar e Configurar o Browser Driver

- **Baixar**:
  - Para Firefox: [Geckodriver](https://github.com/mozilla/geckodriver/releases)
  - Para Chrome: [Chromedriver](https://sites.google.com/chromium.org/driver/)

- **Adicionar ao PATH**:
  - **Windows**: Coloque o driver em uma pasta que esteja no PATH do sistema.
  - **macOS/Linux**: Mova o driver para um diretório que esteja no PATH, como `/usr/local/bin`.

  **Exemplo**:
  ```bash
  mv geckodriver /usr/local/bin/
  ```

## 📝 Estrutura do Projeto
- Test Cases: Definem os passos da automação para abrir o navegador, preencher campos, selecionar checkboxes aleatórios, e interagir com botões e dropdowns.
- Keywords: Palavras-chave customizadas para executar ações como selecionar checkboxes e opções de dropdown, clicar em botões, entre outras.
  
## ⚙️ Configuração
O arquivo de teste contém variáveis que podem ser configuradas:
```bash
${URL}: URL do sistema XCardio.
${BROWSER}: O navegador utilizado nos testes (ex: Firefox, Chrome).
${HASH}: Código de autenticação do sistema.
${CRM}: Número de CRM a ser inserido no campo apropriado.
${NUM_CHECKBOXES}: Quantidade de checkboxes a serem selecionados em cada interação.
```
## 📂 Estrutura do Arquivo de Teste
- Test Case: Hush, CRM, Botão Pesquisa, Rotulagem e Salvar
- Abertura do Navegador: Acessa a URL e maximiza a janela.
- Preenchimento de Formulários: Insere o hash e o CRM nos campos respectivos.
- Interação com Checkboxes e Dropdowns: Seleciona checkboxes e opções de dropdowns aleatoriamente.
- Salvar e Confirmar: Finaliza as interações salvando e confirmando as operações.
- Repetição: O processo é repetido 300 vezes.

## 🚀 Execução
Para executar os testes, rode o seguinte comando no diretório do projeto:

```bash
robot nome_do_arquivo.robot
```

> Certifique-se de que o driver do navegador está corretamente configurado no PATH e que o navegador definido na variável ${BROWSER} está instalado na máquina.