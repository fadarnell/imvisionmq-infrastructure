resource "aws_sqs_queue" "async_upload_queue" {
  name = "async-upload-queue"
}

resource "aws_sqs_queue_policy" "async_upload_queue_policy" {
  queue_url = aws_sqs_queue.async_upload_queue.id

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "SQSPolicy"
    Statement = [
      {
        Effect    = "Allow"
        Principal = {
          AWS = aws_iam_role.ecs_node_api_task_role.arn
        }
        Action    = ["SQS:ReceiveMessage", "SQS:DeleteMessage"]
        Resource  = aws_sqs_queue.async_upload_queue.arn
      },
      {
        Effect    = "Allow",
        Principal = "*",
        Action    = "SQS:SendMessage",
        Resource  = aws_sqs_queue.async_upload_queue.arn,
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = [
              aws_s3_bucket.s3-tenant-storage.arn,
              aws_s3_bucket.s3-tenant-secure-storage.arn
            ]
          }
        }
      }
    ]
  })
}

resource "aws_s3_bucket_notification" "internal_bucket_notification" {
  bucket = aws_s3_bucket.s3-tenant-storage.bucket

  queue {
    queue_arn     = aws_sqs_queue.async_upload_queue.arn
    events        = ["s3:ObjectCreated:Put", "s3:ObjectCreated:Post"]
    filter_prefix = "app/"
  }

  depends_on = [aws_sqs_queue.async_upload_queue]
}

resource "aws_s3_bucket_notification" "secure_bucket_notification" {
  bucket = aws_s3_bucket.s3-tenant-secure-storage.bucket

  queue {
    queue_arn     = aws_sqs_queue.async_upload_queue.arn
    events        = ["s3:ObjectCreated:Put", "s3:ObjectCreated:Post"]
    filter_prefix = "app/"
  }

  depends_on = [aws_sqs_queue.async_upload_queue]
}

resource "aws_s3_bucket_cors_configuration" "internal_bucket_cors" {
  bucket = aws_s3_bucket.s3-tenant-storage.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "GET"]
    allowed_origins = [
      "https://${local.frontend_app_domain}"
    ]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}


resource "aws_s3_bucket_cors_configuration" "secure_bucket_cors" {
  bucket = aws_s3_bucket.s3-tenant-secure-storage.bucket

  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["PUT", "GET"]
    allowed_origins = [
      "https://${local.frontend_app_domain}"
    ]
    expose_headers  = ["ETag"]
    max_age_seconds = 3000
  }
}