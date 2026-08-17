variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  type = map(string)
}

variable "node_instance_types" {
  type    = list(string)
  default = ["t3.medium"]
}

variable "node_desired_size" {
  type = number
}

variable "node_min_size" {
  type = number
}

variable "node_max_size" {
  type = number
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "cluster_admin_principal_arn" {
  description = "IAM principal ARN that receives cluster administrator access to EKS."
  type        = string
}

variable "eks_addons" {
  type = map(object({
    addon_version = string
  }))
}

variable "ebs_csi_role_arn" {
  type = string
}

variable "eks_nodes_sg_id" {
  type = string
}