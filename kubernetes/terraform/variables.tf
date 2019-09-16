#Variáveis utilizadas na configuração do Provider
variable "project_id" {
  description = "Projeto de teste para a Projuris no provedor de nuvem da Google"
}

variable "region" {
  description = "Região onde os recursos estão sendo criados"
}

variable "credential" {
  description = "Credencial utilizada para conexão ao GCP"
}


#Variáveis de configuração do Cluster
variable "cluster_name" {
  description = "Nome do cluster, único com o projeto e a região"
}

variable "zone" {
  description = "Zona de disponibilidade do cluster"
}

#Variáveis do banco de dados do Postgree
variable "database" {
  description = "Banco de dados que será criado"
}

variable "database_user" {
  description = "Usuário de conexão ao banco de dados"
}

variable "database_password" {
  description = "Senha para conexão ao banco de dados"
}
