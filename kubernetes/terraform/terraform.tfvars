// Define as variáveis do provider
project_id = "infra-teste"                     # Projeto em que o cluster será criado
region = "us-central1"                       # Região em que o cluster será criado
credential = "/home/thobias/Documentos/projetos/Projuris/GCP-KEY.json"

// Define as variáveis de cluster Kubernetes
cluster_name = "iac-teste"                   # Nome do cluster
zone = "us-central1-a"                      # Zona do cluster

//Define as variáveis do banco de dados PostgreSQL
database = "projuris"
database_user = "admin"
database_password = "123456"