variable "identifier" {
  description = "A unique identifier for the environment's resources (e.g. labodega-dev)."
  type        = string
}

variable "certificate_remote_state_key" {
  description = "The ACM certificate's remote state key."
  type        = string
}

variable "source_dir" {
  description = "Local directory whose files are uploaded to the frontend bucket (e.g. a static site build output). Set to null to skip uploading."
  type        = string
}
