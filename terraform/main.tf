
provider "aws" {
  region = "ap-south-1"
}


resource "aws_instance" "devops_server" {
  ami           = "ami-0f5ee92e2d63afc18" # Amazon Linux 2 (Mumbai)
  instance_type = "t2.micro"

  tags = {
    Name = "DevOps-EC2"
  }
}
resource "aws_s3_bucket" "devops_bucket" {
  bucket = "devops-project-bharath-001" # ⚠️ change if not unique

  tags = {
    Name = "DevOps-S3-Bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.devops_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}


resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket = aws_s3_bucket.devops_bucket.id

  block_public_acls   = true
  block_public_policy = true
  ignore_public_acls  = true
  restrict_public_buckets = true
}
