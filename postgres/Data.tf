data "aws_eks_cluster" "eks-cluster" {
  name = var.project_name
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = data.aws_eks_cluster.eks-cluster.name
}

data "aws_security_group" "filecut_security_group" {
  filter {
    name   = "group-name"
    values = ["SG-FiapFileCut"]
  }
}