data "mso_tenant" "prod" {
  name = "prod"
}

data "mso_schema" "prod" {
  name = "prod"
}

resource "mso_schema_template" "demo_template" {
  schema_id     = data.mso_schema.prod.id
  name          = var.stack_name
  display_name  = var.stack_name
  tenant_id     = data.mso_tenant.prod.id
  template_type = "cloud_local"
}

resource "mso_schema_template_anp" "anp1" {
  schema_id    = data.mso_schema.prod.id
  template     = mso_schema_template.demo_template.name
  name         = "${var.stack_name}-anp"
  display_name = "${var.stack_name} application profile"
}

resource "mso_schema_template_anp_epg" "front_end_svc" {
  schema_id     = data.mso_schema.prod.id
  template_name = mso_schema_template.demo_template.name
  anp_name      = mso_schema_template_anp.anp1.name
  name          = "front-end-svc"
  display_name  = "front-end microservice EPG"
}

resource "mso_schema_template_anp_epg" "accounts_svc" {
  schema_id     = data.mso_schema.prod.id
  template_name = mso_schema_template.demo_template.name
  anp_name      = mso_schema_template_anp.anp1.name
  name          = "accounts-svc"
  display_name  = "accounts microservice EPG"
}

resource "mso_schema_template_anp_epg" "catalogue_svc" {
  schema_id     = data.mso_schema.prod.id
  template_name = mso_schema_template.demo_template.name
  anp_name      = mso_schema_template_anp.anp1.name
  name          = "catalogue-svc"
  display_name  = "catalogue microservice EPG"
}

resource "mso_schema_template_anp_epg" "notifications_svc" {
  schema_id     = data.mso_schema.prod.id
  template_name = mso_schema_template.demo_template.name
  anp_name      = mso_schema_template_anp.anp1.name
  name          = "notifications-svc"
  display_name  = "notifications microservice EPG"
}

resource "mso_schema_template_contract" "fe_to_accounts_ctrct" {
  schema_id     = data.mso_schema.prod.id
  template_name = mso_schema_template.demo_template.name
  contract_name = "front-end-to-accounts-ctrct"
  display_name  = "front-end-to-accounts-ctrct"
  filter_type   = "bothWay"
  scope         = "context"
  filter_relationship {
    filter_name = "allow-https"
  }
  directives = ["none"]
}

resource "mso_schema_template_contract" "fe_to_catalogue_ctrct" {
  schema_id     = data.mso_schema.prod.id
  template_name = mso_schema_template.demo_template.name
  contract_name = "front-end-to-catalogue-ctrct"
  display_name  = "front-end-to-catalogue-ctrct"
  filter_type   = "bothWay"
  scope         = "context"
  filter_relationship {
    filter_name = "allow-https"
  }
  directives = ["none"]
}

resource "mso_schema_template_contract" "fe_to_notifications_ctrct" {
  schema_id     = data.mso_schema.prod.id
  template_name = mso_schema_template.demo_template.name
  contract_name = "front-end-to-notifications-ctrct"
  display_name  = "front-end-to-notifications-ctrct"
  filter_type   = "bothWay"
  scope         = "context"
  filter_relationship {
    filter_name = "allow-https"
  }
  directives = ["none"]
}

resource "mso_schema_template_anp_epg_contract" "fe_to_accounts_ctrct-prov" {
  schema_id         = data.mso_schema.prod.id
  template_name     = mso_schema_template.demo_template.name
  anp_name          = mso_schema_template_anp.anp1.name
  epg_name          = mso_schema_template_anp_epg.accounts_svc.name
  contract_name     = mso_schema_template_contract.fe_to_accounts_ctrct.contract_name
  relationship_type = "provider"
}

resource "mso_schema_template_anp_epg_contract" "fe_to_accounts_ctrct-cons" {
  schema_id         = data.mso_schema.prod.id
  template_name     = mso_schema_template.demo_template.name
  anp_name          = mso_schema_template_anp.anp1.name
  epg_name          = mso_schema_template_anp_epg.front_end_svc.name
  contract_name     = mso_schema_template_contract.fe_to_accounts_ctrct.contract_name
  relationship_type = "consumer"
}

resource "mso_schema_template_anp_epg_contract" "fe_to_catalogue_ctrct-prov" {
  schema_id         = data.mso_schema.prod.id
  template_name     = mso_schema_template.demo_template.name
  anp_name          = mso_schema_template_anp.anp1.name
  epg_name          = mso_schema_template_anp_epg.catalogue_svc.name
  contract_name     = mso_schema_template_contract.fe_to_catalogue_ctrct.contract_name
  relationship_type = "provider"
}

resource "mso_schema_template_anp_epg_contract" "fe_to_catalogue_ctrct-cons" {
  schema_id         = data.mso_schema.prod.id
  template_name     = mso_schema_template.demo_template.name
  anp_name          = mso_schema_template_anp.anp1.name
  epg_name          = mso_schema_template_anp_epg.front_end_svc.name
  contract_name     = mso_schema_template_contract.fe_to_catalogue_ctrct.contract_name
  relationship_type = "consumer"
}

resource "mso_schema_template_anp_epg_contract" "fe_to_notifications_ctrct-prov" {
  schema_id         = data.mso_schema.prod.id
  template_name     = mso_schema_template.demo_template.name
  anp_name          = mso_schema_template_anp.anp1.name
  epg_name          = mso_schema_template_anp_epg.notifications_svc.name
  contract_name     = mso_schema_template_contract.fe_to_catalogue_ctrct.contract_name
  relationship_type = "provider"
}

resource "mso_schema_template_anp_epg_contract" "fe_to_notifications_ctrct-cons" {
  schema_id         = data.mso_schema.prod.id
  template_name     = mso_schema_template.demo_template.name
  anp_name          = mso_schema_template_anp.anp1.name
  epg_name          = mso_schema_template_anp_epg.front_end_svc.name
  contract_name     = mso_schema_template_contract.fe_to_catalogue_ctrct.contract_name
  relationship_type = "consumer"
}


# data "aws_ami" "ubuntu" {
#   most_recent = true

#   filter {
#     name   = "name"
#     values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
#   }

#   filter {
#     name   = "virtualization-type"
#     values = ["hvm"]
#   }

#   owners = ["099720109477"] # Canonical
# }

# resource "aws_instance" "web" {
#   ami           = data.aws_ami.ubuntu.id
#   instance_type = "t3.micro"

#   tags = {
#     Name = "${var.vm_name}"
#   }
# }
