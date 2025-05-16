terraform {
  cloud {
    organization = "johnmayou"
    workspaces {
      name = "johnmayou-com"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5"
    }
  }
}

provider "cloudflare" {
  api_token = var.cloudflare_api_key
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  type    = "CNAME"
  content = "johnmayou.com"
  proxied = true
  ttl     = 1
}

resource "cloudflare_page_rule" "redirect_www" {
  zone_id  = var.cloudflare_zone_id
  target   = "www.johnmayou.com/*"
  status   = "active"

  actions = {
    forwarding_url = {
      url         = "https://johnmayou.com/$1"
      status_code = 301
    }
  }
}