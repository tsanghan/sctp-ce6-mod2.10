resource "random_id" "server" {
  byte_length = 4
}

module "cdn" {
  source = "terraform-aws-modules/cloudfront/aws"
  version = "3.4.0"

  comment             = "Tsang Han's awesome CloudFront - ${local.random.Name}"
  enabled             = true
  is_ipv6_enabled     = true
  price_class         = "PriceClass_All"
  retain_on_delete    = false
  wait_for_deployment = false
  default_root_object = "home.html"
  tags = local.common_tags

  create_origin_access_identity = false

  origin = {
    something = {
      domain_name = "sctp-staticwebsite-files.s3.ap-southeast-1.amazonaws.com"
      custom_origin_config = {
        http_port              = 80
        https_port             = 443
        origin_protocol_policy = "match-viewer"
        origin_ssl_protocols   = ["TLSv1.1", "TLSv1.2"]
      }
    }
  }

  default_cache_behavior = {
    target_origin_id       = "something"
    viewer_protocol_policy = "allow-all"

    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]
    compress        = true
    query_string    = true
  }

}