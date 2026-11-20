
# AWS Provider
provider "aws" {
  region = var.aws_region
}

# Create S3 Bucket
resource "aws_s3_bucket" "project_bucket" {
  bucket = var.s3_bucket_name

  tags = {
    Name        = var.s3_bucket_name
    Environment = "Project4"
  }
}

# Block Public Access
resource "aws_s3_bucket_public_access_block" "project_bucket_access" {
  bucket = aws_s3_bucket.project_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable Server-Side Encryption
resource "aws_s3_bucket_server_side_encryption_configuration" "project_bucket_encryption" {
  bucket = aws_s3_bucket.project_bucket.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

# Create IAM User
resource "aws_iam_user" "project_user" {
  name = var.iam_username
}

# Create S3 Read-Only Policy
resource "aws_iam_policy" "s3_read_policy" {
  name        = "Project4-S3-ReadOnly-Policy-MB"
  description = "Allow read-only access to the project S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect   = "Allow"
        Action   = var.s3_read_policy.bucket_actions
        Resource = aws_s3_bucket.project_bucket.arn
      },
      {
        Effect   = "Allow"
        Action   = var.s3_read_policy.object_actions
        Resource = "${aws_s3_bucket.project_bucket.arn}/*"
      }
    ]
  })
}

# Attach Policy to IAM User
resource "aws_iam_user_policy_attachment" "attach_s3_policy" {
  user       = aws_iam_user.project_user.name
  policy_arn = aws_iam_policy.s3_read_policy.arn
}
