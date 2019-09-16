#Configuração do Provider
provider "google" {
  version       = "~> 2.5.0"
  project       = "${var.project_id}"
  region        = "${var.region}"
  credentials   = "${file("${var.credential}")}"
}


#Criação do serviço de banco de dados do PostgreeSQL
resource "google_sql_database_instance" "master" {
  name              = "master2"
  database_version  = "POSTGRES_9_6"
  region            = "${var.region}"

  settings{
      tier = "db-f1-micro"
  }
}

#Criação de banco de dados
resource "google_sql_database" "database" {
  name      = "${var.database}"
  instance  = "${google_sql_database_instance.master.name}"
}

#Criação do usuário que será utilizado pelas aplicações
resource "google_sql_user" "user" {
  name      = "${var.database_user}"
  instance  = "${google_sql_database_instance.master.name}"
  host      = "*"
  password  = "${var.database_user}"
}


#Criação do cluster do Kubernetes
resource "google_container_cluster" "primary" {
  name          = "${var.cluster_name}"
  description   = "Cluster criado para teste"
  zone          = "${var.zone}"
  remove_default_node_pool = true
  initial_node_count = 1 #Número de nśo do cluster

  master_auth {
    username = ""
    password = ""

    client_certificate_config {
      issue_client_certificate = false
    }
  }

  #Configuração de cominicação do cubectl com o cluster
    provisioner "local-exec" {
        command = "gcloud container clusters get-credentials ${var.cluster_name} --zone ${var.zone} --project ${var.project_id}"
    }
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name        = "my-node-pool"
  zone        = "${var.zone}"
  cluster     = "${google_container_cluster.primary.name}"
  node_count  = 1

  node_config {
    preemptible = true
    machine_type = "n1-standard-1"

    metadata = {
      disable-legacy-endpoints = "true"
    }

    oauth_scopes = [
      "https://www.googleapis.com/auth/logging.write",
      "https://www.googleapis.com/auth/monitoring",
    ]
  }
}

/*
#Definição de Deployment para o Kubernetes
resource "kubernetes_deployment" "api-deployment" {
  metadata {
    name = "api-exemple"
    labels = {
      test = "api-deployment"
    }
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        test = "api-deployment"
      }
    }

      template {
      metadata {
        labels = {
          test = "api-deployment"
        }
      }

      spec {
        container {
          image = "tfrigini/api:latest"
          name = "api-deployment"
        }
      }
    }
  }
}
*/
