locals {
    namespace = "${var.stack_name}-${terraform.workspace}"
    application_fqdn_list = split(".", var.application_fqdn)
    appended_fqdn_list = terraform.workspace == "prod" ? local.application_fqdn_list : formatlist("%s-${terraform.workspace}", local.application_fqdn_list)
    appended_fqdn = replace(var.application_fqdn, local.application_fqdn_list[var.application_fqdn_workspace_insertion_index], "${local.appended_fqdn_list[var.application_fqdn_workspace_insertion_index]}")
    common_tags = merge(
    var.tags,
    {
      "Terraform"   = "true"
      "Environment" = local.namespace
      "Project"     = "Infrastructure"
    },
  )
}