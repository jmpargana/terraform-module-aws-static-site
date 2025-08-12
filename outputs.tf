
output "dns_zones" {
  value = aws_route53_zone.primary.name_servers
}
