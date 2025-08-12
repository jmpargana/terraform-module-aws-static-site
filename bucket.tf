
resource "aws_s3_bucket" "frontend" {
  region = var.region
  bucket = local.domain

  tags = {
    Name = "Frontend S3 Bucket"
  }
}

resource "aws_s3_bucket_website_configuration" "name" {
  bucket = aws_s3_bucket.frontend.bucket
  index_document {
    suffix = "index.html"
  }
}

// It could be that these rules are the default
# resource "aws_s3_bucket_ownership_controls" "example" {
#   bucket = aws_s3_bucket.frontend.id
#   rule {
#     object_ownership = "BucketOwnerPreferred"
#   }
# }

# resource "aws_s3_bucket_public_access_block" "example" {
#   bucket                  = aws_s3_bucket.frontend.id
#   block_public_acls       = false
#   block_public_policy     = false
#   ignore_public_acls      = false
#   restrict_public_buckets = false
# }

# resource "aws_s3_bucket_acl" "name" {
#   depends_on = [
#     aws_s3_bucket_ownership_controls.example,
#     aws_s3_bucket_public_access_block.example,
#   ]

#   bucket = aws_s3_bucket.frontend.id
#   acl    = "private"
# }
