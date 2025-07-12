# ========== S3 Bucket ==========
resource "aws_s3_bucket" "main" {
  bucket = "${var.bucket_name}"
  force_destroy = true  

  tags = {
    Name        = var.bucket_name
  }
}

# ========== EBS Volume ==========
resource "aws_ebs_volume" "main" {
  availability_zone = var.availability_zone
  size              = var.volume_size
  type              = var.volume_type
  encrypted         = true

  tags = {
    Name        = "TF-ebs"
  }
}
