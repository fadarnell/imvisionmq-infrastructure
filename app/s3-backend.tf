
resource "aws_s3_bucket" "s3-tenant-storage" {
  bucket        = "${var.project}-${var.environment}-tenant-internal-imv-storage"
  force_destroy = false
  tags          = var.tags
}

resource "aws_s3_bucket" "s3-tenant-secure-storage" {
  bucket        = "${var.project}-${var.environment}-tenant-secure-imv-storage"
  force_destroy = false
  tags          = var.tags
}

resource "aws_s3_bucket_ownership_controls" "s3-tenant-storage-ownership" {
  bucket = aws_s3_bucket.s3-tenant-storage.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3-tenant-storage-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3-tenant-storage-ownership]

  bucket = aws_s3_bucket.s3-tenant-storage.id
  acl    = "private"
}

resource "aws_s3_bucket_ownership_controls" "s3-tenant-secure-storage-ownership" {
  bucket = aws_s3_bucket.s3-tenant-secure-storage.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "s3-tenant-secure-storage-acl" {
  depends_on = [aws_s3_bucket_ownership_controls.s3-tenant-secure-storage-ownership]

  bucket = aws_s3_bucket.s3-tenant-secure-storage.id
  acl    = "private"
}
