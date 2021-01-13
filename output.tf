output "aws_alb" {
    value = aws_alb.alb.id
}

output "alb_listener_arn" {
    value = aws_alb_listener.alb_listener.arn
}