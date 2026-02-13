# 🐧 Fun with Linux for Cloud & DevOps Engineers

![Linux](https://imgur.com/VpPW8PM.png)

## 📌 Sobre o Projeto

Este projeto é um laboratório prático focado no domínio dos fundamentos de Linux essenciais para profissionais de Cloud e DevOps.

A proposta é simular um ambiente real de administração de sistemas, explorando gerenciamento de usuários, permissões, estrutura de diretórios, manipulação de arquivos, sistemas de arquivos e integração com infraestrutura AWS (EC2 + EBS).

Ideal para quem deseja fortalecer a base operacional antes de avançar para automação, containers e CI/CD.

---

# 🎯 Objetivo Técnico

Desenvolver proficiência prática em:

- Gerenciamento de usuários e grupos
- Permissões e ownership
- Estrutura de diretórios Linux
- Manipulação de arquivos via CLI
- Uso avançado do vi-editor
- Busca e substituição com comandos
- Gerenciamento de volumes (EBS)
- Criação e montagem de File Systems
- Administração completa do ciclo de vida de um servidor

---

# 🧠 Skills Desenvolvidas

✔ Linux User Management  
✔ Group Management  
✔ File & Directory Permissions  
✔ File System Operations  
✔ Text Processing (sed, grep, vi)  
✔ Volume Management (EBS)  
✔ System Cleanup & Hard Reset  

---

# ☁️ Ambiente Utilizado

- AWS EC2 (Linux Instance)
- AWS EBS (5GB Volume)
- Linux CLI
- vi Editor
- Standard Linux File System Hierarchy

---

# 🚀 Laboratório Prático

## 🔹 Etapa 1 – Administração como root

- Criação de usuários: user1, user2, user3
- Criação de grupos: devops, aws
- Alteração de grupos primários e secundários
- Criação de estrutura de diretórios e arquivos
- Alteração de ownership e group ownership

---

## 🔹 Etapa 2 – Delegação de Permissões (user1)

- Criação de novos usuários: user4, user5
- Criação de grupos: app, database

---

## 🔹 Etapa 3 – Manipulação de Arquivos (user4)

- Criação de diretórios aninhados
- Movimentação de arquivos entre caminhos
- Renomeação de arquivos
- Uso de caminhos absolutos e relativos

---

## 🔹 Etapa 4 – Operações Avançadas (user1)

- Criação de diretórios dentro do /home de outro usuário
- Criação de arquivos utilizando caminho relativo complexo
- Movimentação de arquivos entre diretórios
- Remoção recursiva de diretórios
- Limpeza de diretórios com comando único
- Escrita de conteúdo direto via CLI

---

## 🔹 Etapa 5 – Manipulação de Texto (user2)

- Substituição de texto sem editor (sed)
- Uso do vi para copiar e replicar linhas
- Busca e replace com comando único
- Exclusão definitiva de arquivos

---

## 🔹 Etapa 6 – Auditoria como root

- Busca global de arquivos via find
- Contagem de arquivos no diretório raiz
- Extração da última linha do /etc/passwd

---

# 💾 Gerenciamento de Storage (AWS EBS)

## 🔹 Criação e Anexação

- Criação de volume EBS de 5GB
- Anexação à instância EC2

## 🔹 Configuração

- Criação de File System
- Montagem em /data
- Verificação com df -h
- Criação de arquivo no novo volume

## 🔹 Desmontagem e Limpeza

- Unmount do volume
- Exclusão do diretório /data
- Detach do EBS
- Exclusão do volume
- Terminação da instância EC2

---

# 🔐 Encerramento Controlado

- Remoção de todos os usuários
- Remoção de todos os grupos
- Exclusão de diretórios home
- Reset completo do ambiente

---

# 📊 Resultado Esperados

✔ Domínio sólido da linha de comando Linux  
✔ Segurança e controle de permissões  
✔ Entendimento prático de File Systems  
✔ Gerenciamento completo de storage em nuvem  
✔ Simulação realista de ambiente corporativo  

---

# ⭐ Se este projeto foi útil

Considere:

- Dar uma estrela ⭐  
- Compartilhar com sua rede  
- Adaptar para seu portfólio  
- Criar versão automatizada com Shell Script  

---

> Laboratório essencial para qualquer profissional que deseja evoluir como Cloud ou DevOps Engineer.
