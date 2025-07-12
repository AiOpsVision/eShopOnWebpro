# ========== Get Your Public IP ==========
data "http" "my_ip" {
  url = "https://ipv4.icanhazip.com"
}

# ====== Security Group ======
resource "aws_security_group" "main" {
  name        = "TF-eshop-sg"
  description = "Security group"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ["${chomp(data.http.my_ip.response_body)}/32"]
    }
  }

  # Dynamic Egress Rules
  dynamic "egress" {
    for_each = var.egress_rules
    content {
      description = egress.value.description
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "TF-sg"
  }
}
