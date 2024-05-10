
resource "aws_launch_template" "coalfire_launch_template" {
    name = "coalfire-launch-template"

    image_id      = var.ami
    instance_type = var.ec2_instance_type

    iam_instance_profile {
        name = aws_iam_instance_profile.read_write_profile.name
    }

    block_device_mappings {
        device_name = "/dev/xvda"
        ebs {
            volume_size = 20
        }
    }

    user_data = base64encode(<<-EOF
        #!/bin/bash
        yum install -y httpd
        systemctl start httpd
        systemctl enable httpd
    EOF
    )
    network_interfaces {
        associate_public_ip_address = true
        security_groups = [aws_security_group.autoscaling_security.id]
    }
}

resource "aws_autoscaling_group" "coalfire_asg" {
    min_size             = 2
    max_size             = 6
    desired_capacity     = 2
    vpc_zone_identifier  = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]
    launch_template {
        id      = aws_launch_template.coalfire_launch_template.id
        version = "$Latest"
    }
    
}
