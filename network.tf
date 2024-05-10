#VPC
resource "aws_vpc" "coalfire_vpc" {
    cidr_block = "10.1.0.0/16"
}

#Subnets
resource "aws_subnet" "subnet1" {
    vpc_id            = aws_vpc.coalfire_vpc.id
    cidr_block        = "10.1.0.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
      name = "subnet1"
    }
}

resource "aws_subnet" "subnet2" {
    vpc_id            = aws_vpc.coalfire_vpc.id
    cidr_block        = "10.1.1.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = true

    tags = {
      name = "subnet2"
    }
}

#Subnets
resource "aws_subnet" "subnet3" {
    vpc_id            = aws_vpc.coalfire_vpc.id
    cidr_block        = "10.1.2.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = false

    tags = {
      name = "subnet3"
    }
}

resource "aws_subnet" "subnet4" {
    vpc_id            = aws_vpc.coalfire_vpc.id
    cidr_block        = "10.1.3.0/24"
    availability_zone = "us-east-1b"
    map_public_ip_on_launch = false

    tags = { 
        name = "subnet4"
    }
}

#Security Groups
resource "aws_security_group" "ec2_security" {
    vpc_id = aws_vpc.coalfire_vpc.id
    name = "ec2_security_group"

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        description = "Allow all inbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_security_group" "autoscaling_security" {
    name        = "asg_security_group"
    vpc_id      = aws_vpc.coalfire_vpc.id

    ingress {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "alb_security" {
  name        = "alb_security_group"
  vpc_id      = aws_vpc.coalfire_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.coalfire_vpc.id
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.coalfire_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.public.id
}