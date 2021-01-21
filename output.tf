output "aws_alb" {
    value = aws_alb.alb.id
    description = "The ID of the ALB"
}

output "alb_listener_arn" {
    value = aws_alb_listener.alb_listener.arn
    description = "The 443 Listener ARN of the ALB"
}