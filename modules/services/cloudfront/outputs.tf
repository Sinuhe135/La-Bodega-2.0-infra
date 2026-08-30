output "domain_name" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "arn" {
  value = aws_cloudfront_distribution.s3_distribution.arn
}