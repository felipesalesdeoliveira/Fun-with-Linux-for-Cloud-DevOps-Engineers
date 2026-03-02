# 🚀 Terraform - Infraestrutura EC2 para Linux Lab

Este diretório contém a configuração Terraform para provisionar a infraestrutura necessária para o projeto **Fun with Linux for Cloud & DevOps Engineers** na AWS.

## 📋 Pré-requisitos

- **Terraform** >= 1.0 instalado ([Download](https://www.terraform.io/downloads))
- **AWS CLI** configurada com credenciais (`aws configure`)
- Acesso a uma conta AWS com permissões para criar EC2, VPC, Security Groups, EBS volumes
- Uma EC2 Key Pair criada na AWS (opcional, pode ser criada via Terraform)

## 📦 O que será provisionado

- ✅ **VPC** customizado (10.0.0.0/16)
- ✅ **Subnet** público (10.0.1.0/24)
- ✅ **Internet Gateway** para conectividade
- ✅ **Security Group** com acesso SSH liberado
- ✅ **EC2 t2.micro** (elegível para Free Tier)
- ✅ **EBS Volume** 5GB (gp3) para prática de gerenciamento de discos
- ✅ **Sistema Operacional**: Amazon Linux 2 (latest)

## 🔧 Estrutura de Arquivos

```
terraform/
├── main.tf              # Configuração principal (VPC, EC2, EBS)
├── variables.tf         # Declaração de variáveis
├── outputs.tf           # Outputs para informações úteis
├── terraform.tfvars     # Valores das variáveis (personalize aqui!)
├── user_data.sh         # Script de inicialização da EC2
├── .gitignore          # Arquivos a ignorar no Git
└── README.md           # Este arquivo
```

## 🚀 Como Usar

### 1️⃣ Inicializar Terraform

```bash
cd terraform
terraform init
```

Este comando baixa os providers necessários e prepara o diretório.

### 2️⃣ Personalizar Variáveis (IMPORTANTE!)

Edite o arquivo `terraform.tfvars` conforme suas necessidades:

```hcl
# Mude a região se desejar (padrão: us-east-1)
aws_region = "us-east-1"

# Se você tem uma EC2 Key Pair, coloque o nome aqui
key_pair_name = "seu-keypair-name"

# Restrinja o SSH à seu IP para mais segurança
allowed_ssh_cidr = ["SEU_IP/32"]  # Ex: "203.0.113.100/32"
```

### 3️⃣ Planejar a Infraestrutura

```bash
terraform plan
```

Este comando mostra exatamente o que será criado. Revise a saída!

### 4️⃣ Aplicar a Configuração

```bash
terraform apply
```

Confirme com `yes` quando solicitado. Aguarde 2-3 minutos para a EC2 ser criada.

### 5️⃣ Obter Informações da Instância

```bash
terraform output
```

Você verá:
- IP público da EC2
- ID da instância
- Comando SSH para conectar

## 🔐 Acesso SSH

Após provisionar, conecte-se à instância:

```bash
# Se não especificou uma Key Pair, você precisará criar uma primeiro
ssh -i /caminho/para/sua/key.pem ec2-user@<IP_PUBLICO>
```

**Nota**: Se não forneceu uma Key Pair existente, Terraform usará uma gerada pela AWS.

## 📝 Configuração do Volume EBS

O volume EBS é anexado como `/dev/nvme1n1`. Para usar:

```bash
# 1. Formatar o volume (CUIDADO: irá apagar dados!)
sudo mkfs.ext4 /dev/nvme1n1

# 2. Criar ponto de montagem
sudo mkdir -p /mnt/data

# 3. Montar o volume
sudo mount /dev/nvme1n1 /mnt/data

# 4. Verificar
df -h
```

Para montagem permanente, edite `/etc/fstab`:

```bash
echo "/dev/nvme1n1 /mnt/data ext4 defaults,nofail 0 2" | sudo tee -a /etc/fstab
```

## 🧪 Executar Testes

Após provisionar, teste a infraestrutura:

```bash
# Verificar conectividade
ssh -i your-key.pem ec2-user@<PUBLIC_IP> "lsblk"

# Deve listar:
# - /dev/xvda    (root volume 8GB)
# - /dev/xvdf    (EBS volume 5GB)
```

## 🗑️ Destruir a Infraestrutura

⚠️ **CUIDADO**: Isso removará TODOS os recursos!

```bash
terraform destroy
```

Confirme com `yes` se realmente deseja destruir.

## 🐛 Troubleshooting

### Erro: "InvalidKeyPair.NotFound"
- Certifique-se que a Key Pair existe na região especificada
- Ou deixe `key_pair_name = ""` para que uma nova seja criada

### Erro: "InsufficientInstanceCapacity"
- Mude de região em `terraform.tfvars`
- Ou tente novamente em outro momento

### EC2 lenta para iniciar
- A primeira inicialização pode levar até 5 minutos
- Verifique o log de inicialização (user_data.sh):
  ```bash
  ssh ... tail -f /var/log/cloud-init-output.log
  ```

### Não consigo conectar via SSH
- Verifique o `allowed_ssh_cidr` em `terraform.tfvars`
- Confirme que sua Key Pair está correta
- Verifique Security Group na console AWS

## 📊 Estimativa de Custos

Com a **Free Tier** da AWS:
- EC2 t2.micro: **FREE** (750 horas/mês)
- EBS: **FREE** (30 GB/mês)
- **Custo monthly**: ~$0.00 USD (se dentro do Free Tier)

Após sair do Free Tier: ~$5-8 USD/mês

## 📚 Recursos Úteis

- [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [AWS EC2 Documentation](https://docs.aws.amazon.com/ec2/)
- [Linux Lab Projeto](../README.md)

## 📝 Notas Importantes

1. **Segurança**: `allowed_ssh_cidr = ["0.0.0.0/0"]` permite SSH de qualquer IP. Altere para seu IP!
2. **Custos**: Lembre de destruir resources quando não estiver usando
3. **Backups**: O EBS volume não tem backup automático. Configure se necessário
4. **Monitoramento**: CloudWatch basic monitoring está habilitado

## 🤝 Próximos Passos

Após provisionar e conectar:

1. Formatar e montar o EBS volume
2. Criar estrutura de diretórios para o lab
3. Iniciar exercícios do projeto Linux Lab
4. Usar `terraform state` para gerenciar recursos

---

**Sucesso no seu Linux Lab! 🐧**
