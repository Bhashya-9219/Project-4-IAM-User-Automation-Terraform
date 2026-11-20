
output "s3_bucket_name" {
  description = "Created S3 bucket"
  value       = aws_s3_bucket.project_bucket.bucket
}

output "iam_username" {
  description = "Created IAM username"
  value       = aws_iam_user.project_user.name
}

output "iam_user_arn" {
  description = "IAM user ARN"
  value       = aws_iam_user.project_user.arn
}

output "s3_policy_arn" {
  description = "S3 read-only policy ARN"
  value       = aws_iam_policy.s3_read_policy.arn
}
