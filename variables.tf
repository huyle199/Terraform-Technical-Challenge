variable "ec2_key_pair" {
    default = "ssh_how_to"
}

variable "ec2_instance_type" {
    default = "t2.micro"
}

# variable "ebs_kms_key_arn" {
#     default = null
# }

variable "ami" {
    default = "ami-036c2987dfef867fb"
}