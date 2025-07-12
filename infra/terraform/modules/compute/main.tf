# ========== Key Pair ==========
resource "aws_key_pair" "main" {
  count      = var.public_key_path != "" ? 1 : 0
  key_name   = var.key_pair_name
  public_key = file(var.public_key_path)
}

# ========== EC2 Instance ==========
resource "aws_instance" "web" {
  count                       = var.instance_count
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.public_subnet_id
  vpc_security_group_ids      = var.sg_ids
  key_name                    = var.key_pair_name
  user_data                   = var.user_data
  associate_public_ip_address = true
  monitoring                  = true
  root_block_device {
    volume_size = 12
    volume_type = "gp2"
    encrypted   = true

  }
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 2
  }

  tags = {
    Name = var.instance_name
  }
}


/* عشان استخدم اوتبوت من موديول تانى لمتغير هنا
1. في موديول security:
output "security_group_ids" {
  value = [aws_security_group.main.id]
}

2. جوه compute
variable "sg_ids" {
  type = list(string)
}
و vpc_security_group_ids      = var.sg_ids    // بداخل الec2 

3.  في dev.tf:

module "compute" {
  source       = "./modules/compute"
  sg_ids   = module.security.security_group_ids
}
*/