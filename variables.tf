variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "iam_username" {
  description = "Name of the IAM user"
  type        = string
  default     = "project4-user"
}

variable "s3_bucket_arn" {
  description = "ARN of the S3 bucket"
  type        = string
}

variable "s3_read_policy" {
  description = "S3 read-only permissions"

  type = object({
    bucket_actions = list(string)
    object_actions = list(string)
  })

  default = {
    bucket_actions = ["s3:ListBucket"]
    object_actions = ["s3:GetObject"]
  }
}
variable "s3_bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}
