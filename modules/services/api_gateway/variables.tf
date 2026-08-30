variable "identifier" {
  description = "A unique identifier for the API Gateway route"
  type        = string
}

variable "allow_origins" {
  description = "Allowed origins for the API Gateway CORS configuration"
  type        = list(string)
}