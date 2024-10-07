# Teste DevOps | Bruno Martins Damasceno

### Teste de Provisionamento de Ambiente na AWS com Terraform

No teste solicitado para a vaga de DevOps, foi necessário provisionar a arquitetura de um ambiente na AWS, utilizando **Terraform** para garantir alta disponibilidade, segurança e organização do código. A arquitetura incluía um frontend, um backend (API) e uma camada de banco de dados.

#### O que foi implementado:

- **Provisionamento completo de infraestrutura utilizando Terraform**, incluindo:
  - **Cluster ECS**: Configurado para orquestrar as tarefas e serviços da aplicação.
  - **Serviço ECS e Task Definition**: Definidos para rodar os containers da aplicação.
  - **Segurança**: Implementação de **Security Groups** configurados para controlar o tráfego de entrada e saída, garantindo a segurança da rede.
  - **Rede VPC**: Criação de uma VPC customizada com **Subnets** privadas e públicas, bem como configuração do **Internet Gateway**.
  - **Alta Disponibilidade e Performance**: Utilização de **Load Balancer** para distribuir o tráfego entre as instâncias, e **Auto Scale Group** para garantir a escalabilidade e resiliência da infraestrutura.

#### Parte pendente:

Infelizmente, não consegui concluir a parte referente ao **backend (API)** e ao **banco de dados**, tentei, mas infelizmente essa parte não faz parte do meu dia-a-dia.

#### Ferramenta de Automação (MFAuthorizer):

Durante o teste, utilizei uma ferramenta de automação desenvolvida por mim mesmo, chamada **[EasyMFA-CredentialsAWS](https://github.com/brunomdmd/EasyMFA-CredentialsAWS)**, que facilita a autenticação com MFA na AWS, agilizando o processo de push para o **Amazon ECR (Elastic Container Registry)**.

### Executando o Projeto

## 1. Clonar o Projeto

Para clonar o projeto, abra o terminal e execute o seguinte comando:

```bash
git clone https://github.com/brunomdmd/appBMD
```

## 2. Configurar Credenciais para Acesso ao terraform.tfstate no S3

Criar ou editar o arquivo de credenciais: Abra ou crie o arquivo ~/.aws/credentials e adicione o seguinte conteúdo:

```bash
[default]
aws_access_key_id=SEU_ACCESS_KEY
aws_secret_access_key=SEU_SECRET_ACCESS_KEY
```


## 3. Configurar um Arquivo "credentials" na Raiz do Projeto

Na raiz do projeto clonado, crie um arquivo chamado credentials e adicione as credenciais do usuário "App" (que possui permissões apenas de List e Read no ECS que são usados no Projeto):

```bash
[default]
aws_access_key_id=SEU_ACCESS_KEY
aws_secret_access_key=SEU_SECRET_ACCESS_KEY
```

## 4. Navegar para a Pasta /IaC

Mude para o diretório onde o Terraform está localizado:

```bash
cd /IaC
```

## 5. Executar os Comandos do Terraform

Agora você pode usar o Terraform para planejar e aplicar suas configurações:

```bash
terraform init
terraform plan --out=plano
terraform apply "plano"
```

## 6. Acessar a aplicação

Após o provisionamento ser feito, um output com a URL do Loab Balancer será mostrado, pode acessa-lo pelo brownser.
