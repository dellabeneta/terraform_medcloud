# bucket para backend da infra
resource "aws_s3_bucket" "bucket_infra" {
  bucket        = "medcloud-backend-infra"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "bucket_infra_acl" {
  bucket = aws_s3_bucket.bucket_infra.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_infra_versioning" {
  bucket = aws_s3_bucket.bucket_infra.id
  versioning_configuration {
    status = "Enabled"
  }
}

# bucket para backend da pipeline
resource "aws_s3_bucket" "bucket_pipeline" {
  bucket        = "medcloud-backend-pipeline"
  force_destroy = true
}

resource "aws_s3_bucket_acl" "bucket_pipeline_acl" {
  bucket = aws_s3_bucket.bucket_pipeline.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "bucket_pipeline_versioning" {
  bucket = aws_s3_bucket.bucket_pipeline.id
  versioning_configuration {
    status = "Enabled"
  }
}