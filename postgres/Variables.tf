variable "aws_region" {
  description = "The AWS region to deploy the resources"
  default     = "us-east-1"
  type        = string
}

variable "project_name" {
  type        = string
  default     = "FiapFileCut"
  description = "Especifica o nome do projeto"
}