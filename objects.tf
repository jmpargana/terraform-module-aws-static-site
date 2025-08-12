
resource "aws_s3_object" "website_files" {
  for_each = fileset("${local.dist_dir}", "**")

  bucket = aws_s3_bucket.frontend.id
  key    = each.value
  source = "${local.dist_dir}/${each.value}"
  etag   = filemd5("${local.dist_dir}/${each.value}")


  # TODO: refactor this to locals
  content_type = lookup(
    {
      html = "text/html"
      css  = "text/css"
      js   = "application/javascript"
      json = "application/json"
      png  = "image/png"
      jpg  = "image/jpeg"
      jpeg = "image/jpeg"
      svg  = "image/svg+xml"
      txt  = "text/plain"
    },
    regex("[^.]+$", each.value), # matches file extension after last dot
    "application/octet-stream"   # default if no match
  )
}