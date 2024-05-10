resource "aws_iam_role" "read_write_role" {
  name = "read_write_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy" "read_write_policy" {
  name = "read_write_policy"
  role = aws_iam_role.read_write_role.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::imageswithcoalfire",
          "arn:aws:s3:::imageswithcoalfire/*"
        ]
      },
      {
        Action = [
          "s3:PutObject",
          "s3:PutObjectAcl"
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::logswithcoalfire/*"
        ]
      },
    ]
  })
}

resource "aws_iam_instance_profile" "read_write_profile" {
  name = "read_write_profile"
  role = aws_iam_role.read_write_role.name
}