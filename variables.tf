variable "aws_region" {
  description = "AWS region where the EKS cluster is deployed"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}
