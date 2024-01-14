resource "aws_lb" "web-load-balancer" {
  name                       = "web-external-load-balancer"
  internal                   = false
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-security-group.id]
  subnets                    = [aws_subnet.public-web-subnet-1.id, aws_subnet.public-web-subnet-2.id]

  tags = {
    Name = "Web load balancer"
  }
}

resource "aws_lb" "application-load-balancer" {
  name                       = "app-internal-load-balancer"
  internal                   = true
  load_balancer_type         = "application"
  security_groups            = [aws_security_group.alb-security-group1.id]
  subnets                    = [aws_subnet.private-web-subnet-1.id, aws_subnet.private-web-subnet-2.id]

  tags = {
    Name = "App load balancer"
  }
}

resource "aws_lb_target_group" "web_alb_target_group" {
  name     = "webbalancertg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_01.id
}

resource "aws_lb_target_group" "app_alb_target_group" {
  name     = "appbalancertg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_01.id
}


resource "aws_lb_target_group_attachment" "web-attachment" {
  target_group_arn = aws_lb_target_group.web_alb_target_group.arn
  target_id        = aws_instance.PublicWebTemplate.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "app-attachment" {
  target_group_arn = aws_lb_target_group.app_alb_target_group.arn
  target_id        = aws_instance.PrivateAppTemplate.id
  port             = 80
}

resource "aws_lb_listener" "web_alb_http_listener" {
  load_balancer_arn = aws_lb.web-load-balancer.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_target_group.arn
  }
}

resource "aws_lb_listener" "app_alb_http_listener" {
  load_balancer_arn = aws_lb.application-load-balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_alb_target_group.arn
  }
}
