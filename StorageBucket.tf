resource "aws_s3_bucket_versioning" "file_storage_bucket_versioning" {
  bucket = aws_s3_bucket.file_storage_bucket.bucket

  versioning_configuration {
    status = "Enabled"
  }

  depends_on = [
    aws_s3_bucket.file_storage_bucket
  ]
}

resource "aws_s3_bucket" "file_storage_bucket" {
  bucket = "fiapfilecut-s3-storage-bucket"
  acl    = "private"

  versioning {
    enabled = false
  }

  tags = {
    Name        = "File Storage Bucket"
    Environment = "Production"
  }

  depends_on = [
    aws_eks_cluster.eks-cluster
  ]
}

# Kubernetes Secret for the S3 bucket
resource "kubernetes_secret" "s3_bucket_secret" {
  metadata {
    name      = "s3-storage-bucket"
  }

  data = {
    s3_bucket_name = aws_s3_bucket.file_storage_bucket.bucket
    s3_access_key  = "${var.aws_access_key}"
    s3_secret_key  = "${var.aws_secret_key}"
    s3_region      = "${var.aws_region}"
  }

  depends_on = [
    aws_s3_bucket.file_storage_bucket  # Secret creation depends on the S3 bucket
  ]
}