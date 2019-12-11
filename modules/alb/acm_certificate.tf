data "aws_acm_certificate" "example" {
  domain   = "*.smuriana.com"
  statuses = ["ISSUED"]
}