##############################
# Parametros passados de execução
##############################
variable "aws_account_id" {
  type        = string
  description = "Representa o ID da conta da AWS para o voclabs. Esta variável é obrigatória."
}

##############################
# Constantes
##############################
variable "project_name" {
  type        = string
  default     = "FiapFileCut"
  description = "Especifica o nome do projeto"
}

variable "aws_region" {
  type        = string
  default     = "us-east-1"
  description = "Define a região padrão da AWS onde os recursos serão provisionados."
}

variable "aws_eks_instance_type" {
  type        = string
  default     = "t3a.medium"
  description = "Especifica o tipo de instância EKS que será utilizada, sendo uma instância de uso geral com equilíbrio entre capacidade de computação e custo."
}

variable "aws_policy_arn" {
  type        = string
  default     = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
  description = "Define o Amazon Resource Name (ARN) de uma política específica que pode ser aplicada a recursos ou usuários. Esta variável é obrigatória."
}

variable "aws_eks_authentication_mode" {
  type        = string
  default     = "API_AND_CONFIG_MAP"
  description = "Especifica a configuração de acesso desejada, incluindo tanto a API quanto um mapa de configuração."
}