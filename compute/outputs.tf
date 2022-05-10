# --- compute/outputs.tf ---

output "autoscaling_group" {
  value = aws_autoscaling_group.web.id
}