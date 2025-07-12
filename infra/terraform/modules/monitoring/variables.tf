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

variable "ec2_instance_id" {
  description = "The ID of the EC2 instance to monitor"
  type        = string
}
