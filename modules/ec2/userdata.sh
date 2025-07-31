#!/bin/bash

exec > >(tee -a /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# Atualizar pacotes
dnf update -y

# Instalar Docker
dnf install -y docker
systemctl start docker
systemctl enable docker

# Docker sem sudo
usermod -aG docker ec2-user

# Instalar Docker Compose v2 como plugin
mkdir -p /usr/libexec/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.29.2/docker-compose-linux-x86_64 \
  -o /usr/libexec/docker/cli-plugins/docker-compose
chmod +x /usr/libexec/docker/cli-plugins/docker-compose

# Criar rede externa se ainda não existe
docker network create votingapp_network || true

# Criar diretório do projeto
mkdir -p /home/ec2-user/votingapp

# Criar docker-compose.yml
cat > /home/ec2-user/votingapp/docker-compose.yml <<EOF
version: '3'
services:
  vote:
    image: dockersamples/examplevotingapp_vote:before
    ports:
      - "80:80"
    depends_on:
      - redis
    environment:
      - REDIS_HOST=redis
  result:
    image: dockersamples/examplevotingapp_result:before
    ports:
      - "5000:80"
    depends_on:
      - db
    environment:
      - POSTGRES_HOST=db
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=postgres
  worker:
    image: dockersamples/examplevotingapp_worker:latest
    depends_on:
      - redis
      - db
    environment:
      - REDIS_HOST=redis
      - POSTGRES_HOST=db
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=postgres
  redis:
    image: redis:alpine
  db:
    image: postgres:12
    environment:
      - POSTGRES_USER=postgres
      - POSTGRES_PASSWORD=postgres
      - POSTGRES_DB=postgres
    volumes:
      - db_data:/var/lib/postgresql/data

volumes:
  db_data:

networks:
  default:
    external:
      name: votingapp_network
EOF

# Corrigir permissões
chown -R ec2-user:ec2-user /home/ec2-user/votingapp

# Executar o docker-compose como ec2-user
runuser -l ec2-user bash -c "cd /home/ec2-user/votingapp && docker compose up -d"

# cria diretorio para a API integrada
mkdir -p /home/ec2-user/api-ci-cd

#criar o docker-compose.yml para a API integrada
cat > /home/ec2-user/api-ci-cd/docker-compose.yml <<EOF
version: "3.9"

services:
  api:
    image: alepertile28/stats-api:latest
    ports:
      - "8000:80"
    restart: always
EOF

# Corrigir permissões
chown -R ec2-user bash -c "cd /home/ec2-user/api-ci-cd && docker compose up -d"
