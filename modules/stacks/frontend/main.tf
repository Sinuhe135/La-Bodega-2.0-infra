locals {
  certificate_remote_state_bucket = "labodega-state"

  mime_types = {
    ".html"  = "text/html"
    ".htm"   = "text/html"
    ".css"   = "text/css"
    ".js"    = "application/javascript"
    ".mjs"   = "application/javascript"
    ".json"  = "application/json"
    ".svg"   = "image/svg+xml"
    ".png"   = "image/png"
    ".jpg"   = "image/jpeg"
    ".jpeg"  = "image/jpeg"
    ".gif"   = "image/gif"
    ".ico"   = "image/x-icon"
    ".webp"  = "image/webp"
    ".woff"  = "font/woff"
    ".woff2" = "font/woff2"
    ".ttf"   = "font/ttf"
    ".map"   = "application/json"
    ".txt"   = "text/plain"
    ".xml"   = "application/xml"
  }
}

resource "aws_s3_bucket" "app_bucket" {
  bucket = "${var.identifier}-frontend"
}

resource "aws_s3_object" "app_files" {
  for_each = fileset(var.source_dir, "**")

  bucket       = aws_s3_bucket.app_bucket.id
  key          = each.value
  source       = "${var.source_dir}/${each.value}"
  etag         = filemd5("${var.source_dir}/${each.value}")
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
}

resource "aws_cloudfront_origin_access_control" "default" {
  name                              = "${var.identifier}-oac"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

module "cloudfront" {
  source = "../../services/cloudfront"

  certificate_remote_state_bucket = local.certificate_remote_state_bucket
  certificate_remote_state_key    = var.certificate_remote_state_key

  bucket_regional_domain_name             = aws_s3_bucket.app_bucket.bucket_regional_domain_name
  aws_cloudfront_origin_access_control_id = aws_cloudfront_origin_access_control.default.id
}
