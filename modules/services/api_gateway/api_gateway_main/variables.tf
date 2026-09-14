variable "identifier" {
  description = "A unique identifier for the API Gateway route"
  type        = string
}

variable "allow_origins" {
  description = "Allowed origins for the API Gateway CORS configuration"
  type        = list(string)
}

variable "domain_name" {
  description = "Custom domain name to map to the API Gateway"
  type        = string
}

variable "domain_certificate_arn" {
  description = "ARN of the ACM certificate for the custom domain (must be in the same region as the API for REGIONAL endpoints)"
  type        = string
}