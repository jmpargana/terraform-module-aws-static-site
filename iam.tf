
resource "aws_s3_bucket_policy" "example" {
  bucket = aws_s3_bucket.frontend.id
  policy = data.aws_iam_policy_document.cloudfront.json
}

# resource "aws_s3_bucket_policy" "public_read" {
#   bucket = aws_s3_bucket.frontend.id
#   policy = jsonencode({
#     Version = "2012-10-17"
#     Statement = [
#       {
#         Sid       = "PublicReadGetObject"
#         Effect    = "Allow"
#         Principal = "*"
#         Action    = "s3:GetObject"
#         Resource  = "${aws_s3_bucket.frontend.arn}/*"
#       }
#     ]
#   })
# }

data "aws_iam_policy_document" "cloudfront" {
  statement {
    # effect  = "Allow"
    actions = ["s3:GetObject"]

    resources = [
      aws_s3_bucket.frontend.arn,
      "${aws_s3_bucket.frontend.arn}/*",
    ]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.example.iam_arn]
    }

    # condition {
    #   test     = "StringEquals"
    #   variable = "AWS:SourceArn"
    #   values = [
    #     aws_cloudfront_distribution.example.arn
    #   ]
    # }
  }
}

resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "OAC cloudchallenge.icu"
  description                       = "Origin Access Controls for Static Website Hosting"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_origin_access_identity" "example" {
  comment = "OAI account to access S3"
}