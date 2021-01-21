variable "private_key_file" {
  type = string
  description = "Path to a the PEM-formatted private key for the avalon website. This will be loaded into AWS Certificate Manager(ACM) and used by the Application Load Balancer(ALB). Max supported RSA Key size is 2048"
  sensitive = true
}

variable "certificate_body_file" {
  type = string
  description = "Path the PEM-formatted signed certificate for the avalon website, this will be loaded into ACM and used by the ALB."
  sensitive = true
}

variable "certificate_chain_file" {
  type = string
  description = "Path to the PEM-formatted interim or chain certificate, some regions may require the chain cert be in 'reverse' format."
  sensitive = true
}

variable "stack_name" {
  default = "stack"
  description = "Name of the stack, helps delineate between different projects."
}

variable "vpc_id" {
  type = string
  description = "VPC that will be used by terraform, this VPC is called via data only, terraform will not attempt to manage the existence of the VPC"
}

variable "subnet_ids" {
    type = list(string)
    description = "List of subnet IDs, requires two in different availability zones"
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "Map of tags, will be added to the common tags local"
}