resource "aws_alb" "alb" {
  name = "${local.namespace}-alb"
  subnets         = var.subnet_ids
  security_groups = [aws_security_group.alb.id]
  internal        = true  
  idle_timeout = "300"
}

resource "aws_lb_listener" "alb_forward_https" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = "443"
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate.alb_cert.arn

  default_action {
    type             = "fixed-response"
  
    fixed_response {
      content_type = "text/plain"
      message_body = "Emory University Libraries"
      status_code  = "200"
    }
  }
}

# Web listener rule and target group
resource "aws_lb_listener_rule" "alb_web_listener_rule" {
  listener_arn = aws_alb_listener.alb_listener.arn
  priority     = 99

  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_web.arn
  }

  condition {
    host_header {
      values = [local.appended_fqdn]
    }
  }
}

# Import web and streaming certificate 
resource "aws_acm_certificate" "alb_cert" {
  private_key = file(var.private_key_file)
  certificate_body = file(var.certificate_body_file)
  certificate_chain = file(var.certificate_chain_file)
  
  tags = local.common_tags

  lifecycle {
    create_before_destroy = true
  }
}