variable "key_pair_name" {
  description = "Name of the key pair"
}

variable "public_key_path" {
  description = "Path to the public key file (e.g. ~/.ssh/id_rsa.pub)"
  default     = ""
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

variable "public_subnet_id" {
  description = "Subnet ID where the EC2 instance will be deployed"
  type        = string
}

variable "sg_ids" {
  description = "List of security group IDs to associate with the instance"
  type        = list(string)
}

variable "user_data" {
  description = "Optional user data script"
  default     = ""
}

variable "instance_name" {
  type        = string
  description = "EC2 Name Tag"
}

variable "role" {
  type        = string
  description = "Role of the instance (e.g., webapp, sqlserver)"
}

variable "environment" {
  type        = string
  description = "Environment tag (e.g., dev, prod)"
}
