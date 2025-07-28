# AWS Terraform Lab 🚀

Este repositório contém um laboratório prático de infraestrutura como código (IaC) usando **Terraform**, com foco em boas práticas, modularização, CI/CD com GitHub Actions e utilização do **Free Tier da AWS**.

## 📌 Visão Geral

- ✅ Deploy automático de instância EC2 com Docker e Docker Compose instalados via **User Data**.
- ✅ Deploy automático da aplicação **Voting App** (vote, result, worker, redis, postgres).
- ✅ Liberação de portas no **Security Group** para acesso externo.
- ✅ Utilização de **S3 + DynamoDB** como backend remoto para gerenciamento de estado.
- ✅ Infraestrutura totalmente modular e versionada.
- ✅ CI/CD com **GitHub Actions** executando `terraform fmt`, `validate`, `plan` e `apply`.

---

##  Estrutura do Projeto

```plaintext
.
├── main.tf                      # Composição principal do ambiente
├── backend/                     # Configuração de S3 + DynamoDB
├── modules/
│   ├── ec2/                     # EC2 com docker + voting app via User Data
│   └── security_group/         # Security Group com regras para HTTP e SSH
├── .github/workflows/
│   └── terraform.yml           # Pipeline CI/CD com GitHub Actions
├── outputs.tf
├── variables.tf
└── README.md                   # Este arquivo
```

##  Aplicações Instaladas

Na instância EC2, via **User Data**, são instalados automaticamente:

- [x] **Docker**
- [x] **Docker Compose**
- [x] **Voting App** (vote, result, redis, postgres, worker) via `docker-compose.yml`

---

##  Backend Remoto

O gerenciamento do estado do Terraform está configurado com:

-  **S3 Bucket** (state storage)
-  **DynamoDB Table** (lock do state)

Esses recursos são mantidos manualmente ou via Terraform (caso deseje).

---

##  CI/CD com GitHub Actions

Sempre que há push no repositório, o pipeline realiza:

1. `terraform fmt -check -recursive`
2. `terraform init`
3. `terraform validate`
4. `terraform plan`
5. `terraform apply` (se estiver configurado para isso)

As credenciais são mantidas em **GitHub Secrets** de forma segura.

---

##  Segurança

-  Nenhuma `access_key` ou `secret_key` está presente no repositório.
-  As chaves estão armazenadas de forma segura em **GitHub Secrets**.
-  O acesso SSH é possível via chave gerada pelo Terraform (armazenada localmente).

---

##  Pré-Requisitos

- Conta **AWS Free Tier**
- **Terraform** 1.x
- **Git + GitHub**
- **AWS CLI** configurado (para testes locais)

---

##  Exemplo de Acesso

Acesse a aplicação após o provisionamento:

http://<IP_DA_INSTANCIA_EC2>:5000


Use `terraform output` para ver o IP público da instância.

---

##  Checklist das Boas Práticas

- [x] Modularização da infraestrutura
- [x] Separação de responsabilidades por pasta
- [x] Backend remoto com lock
- [x] CI/CD com GitHub Actions
- [x] Segurança com GitHub Secrets
- [x] User Data automatizando ambiente
- [x] Aplicação Docker com persistência

---


##  Licença

Este projeto é livre para fins educacionais e demonstrativos.

---

##  Autor

**Alexandre Augusto Pertile da Luz**  
[LinkedIn](https://www.linkedin.com/in/alexandre-pertile-36a350102) | [GitHub](https://github.com/alepertile28)
