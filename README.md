# containers ginga

Este repositório contém as imagens Docker e os scripts necessários para a execução de um sistema de interação multimodal, integrado com o Ginga (framework de aplicações interativas para TV Digital), módulos de reconhecimento de voz, gestos e expressão facial.

Os módulos de gestos e expressão facial fazem uso de câmera, e por isso, uma imagem adicional de **câmera virtual** foi criada para suportar esses módulos.

## Estrutura do repositório

- **ginga-img**: Imagem Docker do Ginga.
- **vrecog-img**: Imagem Docker do módulo de reconhecimento de voz.
- **handpose-img**: Imagem Docker do módulo de reconhecimento de gestos.
- **frecog-img**: Imagem Docker do módulo de reconhecimento de expressão facial.
- **vcam-img**: Imagem Docker para a câmera virtual que suporta os módulos de gestos e expressão facial.
- **run.sh**: Script para facilitar a execução do sistema.
- **docker-compose.yml**: Arquivo de configuração para executar os contêineres via Docker Compose.

## Requisitos

- **Linux** (ou WSL): Os scripts estão escritos em bash e fazem configurações baseadas no sistema de arquivos do Linux. Não tendo um Linux instalado na máquina, pode ser usada máquina virtual sem problema.
- **Docker**: Para executar os contêineres, é necessário ter o Docker instalado. Consulte a [documentação oficial do Docker](https://docs.docker.com/engine/install/) para mais informações sobre a instalação.

## Instruções de uso

### Passo 0: Clonar o repositório

```bash
$ git clone https://github.com/PedroAlvesV/containers-ginga.git
```

### Passo 1: Carregar as Imagens Docker

Para carregar as imagens Docker, utilize o comando `docker load` para cada uma das imagens fornecidas:

```bash
$ docker load -i <nome-da-imagem>.tar
```


Opcionalmente, use o comando abaixo para listar as imagens Docker carregadas:

```bash
$ docker image ls
```

### Passo 2: Preparar a Aplicação NCL

A aplicação NCL precisa ter o arquivo principal denominado `main.ncl`, que é o ponto de entrada para a execução da aplicação pelo contêiner.

### Passo 3: Executar o Sistema com o Script `run.sh`

Após carregar as imagens e preparar a aplicação NCL, execute o sistema usando o script `run.sh`. O script facilita a execução dos contêineres necessários, incluindo os módulos de reconhecimento de voz, gestos e expressão facial. A sintaxe de uso é a seguinte:

```bash
$ ./run.sh <caminho-da-aplicacao-ncl> <modulo-1> <modulo-2> ... <modulo-n>
```


Exemplo de uso:

```bash
$ ./run.sh ginga/app1 handpose vrecog
```


**Importante:**
- O contêiner de câmera virtual (`vcam-img`) não deve ser passado como argumento. O script `run.sh` irá iniciar automaticamente o contêiner de câmera virtual quando for necessário para os módulos de gestos ou expressão facial.
- O caminho para a aplicação NCL deve ser um diretório contendo um arquivo chamado **main.ncl**.


### Passo 4: Testar e Validar

Após iniciar os contêineres, a aplicação NCL será carregada, e os módulos de reconhecimento de voz, gestos e expressão facial estarão disponíveis. Se você encontrar qualquer problema, por favor, verifique os logs do Docker para mais detalhes e não hesite em abrir uma *issue*.

## Notas Finais

- Certifique-se de que as imagens Docker estejam corretamente carregadas antes de executar os contêineres.
- O script `run.sh` foi desenvolvido para simplificar a execução do sistema, mas você também pode gerenciar os contêineres manualmente (não recomendado) usando o Docker CLI, se preferir.

## Contato

Se você tiver dúvidas ou encontrar problemas, sinta-se à vontade para abrir uma *issue* neste repositório.	
