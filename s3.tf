
resource "aws_s3_bucket" "images_bucket" {
    bucket = "imageswithcoalfire"

}


resource "aws_s3_bucket" "logs_bucket" {
    bucket = "logswithcoalfire"

}

resource "aws_s3_bucket_lifecycle_configuration" "images_lifecycle" {
    bucket = aws_s3_bucket.images_bucket.id

    rule {
        id      = "Memes_folder_rule"
        status  = "Enabled"

        transition {
            days          = 90
            storage_class = "GLACIER"
        }
        filter {
            prefix = "Memes/"
        }
    }
}

resource "aws_s3_bucket_lifecycle_configuration" "logs_lifecycle" {
    bucket = aws_s3_bucket.logs_bucket.id

    rule {
        id      = "Active_folder_rule"
        status  = "Enabled"

        transition {
            days          = 90
            storage_class = "GLACIER"
        }
        filter {
            prefix = "Active/"
        }
    }

    rule {
        id      = "Inactive_folder_rule"
        status  = "Enabled"

        expiration {
            days = 90
        }
        filter {
            prefix = "Inactive/"
        }
    }
}

# # Create S3 bucket for logs using the terraform-aws-s3 module
# module "logs_bucket" {
#     source = "github.com/Coalfire-CF/terraform-aws-s3"
#     # block_public_acls   = true
#     # block_public_policy = true
#     name                = "logswithcoalfire"

#     lifecycle_configuration_rules = [
#     {
#         id : "Active_folder_rule",
#         enabled : "true",
#         enable_glacier_transition : "true",
#         glacier_transition_days : 90,
#         prefix : "Active/"
#         },
    
#     {
#         id       :  "Inactive_folder_rule"
#         enabled  :  "true"
#         expiration_days   :  "90"
#         prefix : "Inactive/"
#         }
#     ] 
# }

