provider "aws" {
  region = var.aws_region
}

resource "aws_db_instance" "postgresql" {
  identifier        = "postgres-instance"
  engine            = "postgres"
  engine_version    = "13"  # Adjust the version as needed
  instance_class    = "db.t3.medium"  # Choose your instance size
  allocated_storage = 20  # Set storage size (GB)
  storage_type      = "gp3"  # General Purpose SSD
  username          = "postgres"
  password          = "postgres"  # Replace with a secure password
  db_name           = "keycloak"
  multi_az          = false  # Set to true if you need Multi-AZ deployment for high availability
  publicly_accessible = false  # Set to true if the instance needs to be publicly accessible
  vpc_security_group_ids = [data.aws_security_group.filecut_security_group.id]  # Provide your VPC security group ID
  final_snapshot_identifier = "postgres-instance-snapshot"
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks-cluster.endpoint
  token                  = data.aws_eks_cluster_auth.cluster_auth.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority[0].data)
}

resource "kubernetes_secret" "postgresql_username" {
  metadata {
    name = "postgresql-user"
  }

  data = {
    username = base64encode("postgres")
  }
}

resource "kubernetes_secret" "postgresql_password" {
  metadata {
    name = "postgresql-password"
  }

  data = {
    password = base64encode("postgres")  # Make sure to encode the password
  }
}

resource "kubernetes_secret" "postgresql_dbname" {
  metadata {
    name = "postgresql-db"
  }

  data = {
    dbname = base64encode("keycloak")
  }
}