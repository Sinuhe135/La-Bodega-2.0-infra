variable "identifier" {
  description = "A unique identifier for the environment's resources (e.g. labodega-dev)."
  type        = string
}

variable "certificate_remote_state_key" {
  description = "The ACM certificate's remote state key."
  type        = string
}
