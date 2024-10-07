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

#### Procedimento para push no ECR:

1. Execute o comando de login no ECR:
   ```bash
   aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 123456789012.dkr.ecr.us-east-1.amazonaws.com

2. Marque a imagem com a nova tag:
   ```bash
   docker tag ECRNAME:VERSION 123456789012.dkr.ecr.us-east-1.amazonaws.com/ECRNAME:VERSION:VERSION

1. Faça o push da imagem para o ECR:
   ```bash
   docker push 123456789012.dkr.ecr.us-east-1.amazonaws.com/ECRNAME:VERSION:VERSION
