resource "aws_s3_bucket" "s3_bucket_dl" {
  bucket = "datalake-storage-example-ccorzo"

  tags = {
    Name        = "Datalake Storage"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_object" "s3_processed_object_dl" {
  bucket = aws_s3_bucket.s3_bucket_dl.id
  key    = "processed/"
}

resource "aws_s3_bucket_object" "s3_to_procces_object_dl" {
  bucket = aws_s3_bucket.s3_bucket_dl.id
  key    = "to_procces/"
}

resource "aws_s3_bucket_object" "s3_source_code_object_dl" {
  bucket = aws_s3_bucket.s3_bucket_dl.id
  key    = "source_code/test.py"
  source = "source-code/test.py"
}