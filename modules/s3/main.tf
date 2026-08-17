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


resource "aws_s3_bucket_acl" "storage_bucket" {
  depends_on = [aws_s3_bucket_ownership_controls.storage_bucket]

  bucket = aws_s3_bucket.storage_bucket.id
  acl    = "private"

}