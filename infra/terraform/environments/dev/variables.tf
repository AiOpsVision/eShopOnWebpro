variable "key_pair_name" {
  description = "Name of the key pair"
  type        = string
  default     = "eshoponweb-key"
}

variable "public_key_path" {
  description = "Path to the public key file (e.g. ~/.ssh/id_rsa.pub)"
}

variable "instance_count" {
  description = "Number of EC2 instances"
  type        = number
}

variable "instance_type" {
  description = "EC2 instance type (should be t2.micro or t3.micro for free tier)"
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
}


variable "log_retention_days" {
  description = "Retention days for log group"
  type        = number
}

variable "alert_email" {
  description = "Email address to receive SNS alerts"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU usage % threshold to trigger alert"
  type        = number
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}

variable "enable_dns" {
  description = "Whether to enable DNS support and hostnames"
  type        = bool
}

variable "availability_zones" {
  description = "List of availability zones for subnet distribution"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
  default     = []  # لو مش هتستخدمها حاليًا، تبقى optional
}


variable "ingress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}
variable "egress_rules" {
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "bucket_name" {
  description = "اسم البكت S3"
  type        = string
}

variable "availability_zone" {
  description = "الزون اللي هيتحط فيه EBS"
  type        = string
}

variable "volume_size" {
  description = "سعة الـ EBS بالجيجابايت (تكون <= 30 للـ Free Tier)"
  type        = number
  default     = 8
}

variable "volume_type" {
  description = "نوع الـ EBS (يفضل gp2 عشان مجاني)"
  type        = string
  default     = "gp2"
}

variable "aws_access_key" {
  type      = string
  sensitive = true
}

variable "aws_secret_key" {
  type      = string
  sensitive = true
}
