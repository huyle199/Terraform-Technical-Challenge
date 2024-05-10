provider "aws" {
    region = "us-east-1" 
}


resource "aws_instance" "ec2_instance" {
    ami           = var.ami
    instance_type = var.ec2_instance_type
    key_name      = var.ec2_key_pair
    subnet_id     = aws_subnet.subnet2.id
    vpc_security_group_ids = [aws_security_group.ec2_security.id]
    root_block_device {
        volume_size = 20
    }
}

# module "ec2_instances" {
#     source = "github.com/Coalfire-CF/terraform-aws-ec2"

#     name = "coalfire-ec2-test"
#     vpc_id        = aws_vpc.coalfire_vpc.id
#     subnet_ids    = [aws_subnet.subnet2.id]
#     ami           = var.ami
#     ec2_instance_type = var.ec2_instance_type
#     root_volume_size  = 20
#     ec2_key_pair = var.ec2_key_pair
#     ebs_kms_key_arn = var.ebs_kms_key_arn
#     global_tags = {}
# }
