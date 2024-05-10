
resource "aws_lb" "coalfire_alb" {
    name               = "application-balancer"
    internal           = false
    load_balancer_type = "application"
    subnets            = [aws_subnet.subnet3.id, aws_subnet.subnet4.id]
    security_groups = [aws_security_group.alb_security.id]
}

resource "aws_lb_listener" "http_listener" {
    load_balancer_arn = aws_lb.coalfire_alb.arn
    port              = 80
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.autoscaling_target.arn
    }
}

resource "aws_lb_target_group" "autoscaling_target" {
    name     = "asg-target-group"
    port     = 443
    protocol = "HTTP"
    vpc_id   = aws_vpc.coalfire_vpc.id

    health_check {
        path                = "/"
        protocol            = "HTTP"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 5
        interval            = 30
    }
}
