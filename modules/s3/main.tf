resource "aws_s3_bucket" "storage_bucket" {
  bucket        = "${var.cluster_name}-storage"
  force_destroy = true

  tags = {
    Name = "${var.cluster_name}-storage"
  }
}

resource "aws_s3_bucket_ownership_controls" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id


  rule {
    object_ownership = "BucketOwnerPreferred"
  }

}


resource "aws_s3_bucket_public_access_block" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id

  block_public_acls       = true
  ignore_public_acls      = true
  block_public_policy     = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "storage_bucket" {
  bucket = aws_s3_bucket.storage_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadStatic"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.storage_bucket.arn}/static/*"
      }
    ]
  })

  depends_on = [aws_s3_bucket_public_access_block.storage_bucket]
}