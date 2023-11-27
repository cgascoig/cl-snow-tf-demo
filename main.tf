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
