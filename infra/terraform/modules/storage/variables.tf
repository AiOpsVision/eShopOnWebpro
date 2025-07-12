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
