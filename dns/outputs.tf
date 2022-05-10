# --- dns/outputs.tf ---

output "certificate_arn" {
  value = aws_acm_certificate_validation.example.certificate_arn
}