resource "aws_lb" "test_alb" {
  name                       = "test-alb"
  internal                   = false
  load_balancer_type         = "application"
  subnets                    = aws_subnet.public_subnets[*].id
  enable_deletion_protection = false
  security_groups            = [aws_security_group.alb_sg.id]
}

resource "aws_lb_target_group" "test_alb_target_group" {
  name     = "test-alb-target-group"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = aws_vpc.Project_1_vpc.id
  health_check {
    healthy_threshold   = 3
    interval            = 60
    unhealthy_threshold = 3
    matcher             = "200"
  }
}

resource "aws_lb_listener" "test_listener" {
  load_balancer_arn = aws_lb.test_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.test_alb_target_group.arn
  }
}
