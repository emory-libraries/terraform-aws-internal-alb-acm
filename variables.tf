variable "application_fqdn" {
  type = string
  description = <<EOF
    The fully qualified production domain name. This is name is used only by the application load balancer, not route53.
    Note that the template will also create another domain name for streaming that is streaming.{application_fqdn}.
    EOF
}
variable "application_fqdn_workspace_insertion_index" {
  type = number
  default = 0
  description = <<EOF
    The application fqdn is split into a list at each '.', this variable is the index (first object is 0) where the workspace will be appended.
    For example if the application fqdn is 'avr.emory.edu', this variable is set to 0, and the workspace is test, the output will be avr-test.emory.edu.
    If the workspace is 'prod' then nothing is appended to the fqdn and the address on the alb would be 'avr.emory.edu'. 
    EOF
}

variable "private_key_file" {
  type = string
  description = "Path to a the PEM-formatted private key for the avalon website. This will be loaded into AWS Certificate Manager(ACM) and used by the Application Load Balancer(ALB). Max supported RSA Key size is 2048"
}

variable "certificate_body_file" {
  type = string
  description = "Path the PEM-formatted signed certificate for the avalon website, this will be loaded into ACM and used by the ALB."
}

variable "certificate_chain_file" {
  type = string
  description = "Path to the PEM-formatted interm or chain certificate, some regions may require the chain cert be in 'reverse' format."
}

variable "stack_name" {
  default = "stack"
  description = "Name of the stack, helps delinate between different projects."
}

variable "vpc_id" {
  type = string
  description = "VPC that will be used by terraform, this VPC is called via data only, terraform will not attempt to manage the existence of the VPC"
}

variable "subnet_ids" {
    type = list(string)
    description = "List of subnet IDs, requires two in different availablity zones"
}

variable "tags" {
  type    = map(string)
  default = {}
  description = "Map of tags, will be added to the common tags local"
}