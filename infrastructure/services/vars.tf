variable "vpc_id" {
  default = "vpc-71846417"
}

variable "public_subnets" {
  default = ["subnet-f12cd6b9", "subnet-b66f14ee", "subnet-f3ab6395"]
}

variable "elastic_beanstalk_zone_id" {
  default = "Z2PCDNR3VC2G1N"
#  default = "Z1GM3OXH4ZPM65"
  description = "https://docs.aws.amazon.com/general/latest/gr/elb.html"
#  description = "https://docs.aws.amazon.com/general/latest/gr/elasticbeanstalk.html"
}

variable "health_check_url" {
  default = "/health-check"
}

variable "solution_stack_name" {
  default = "64bit Amazon Linux 2023 v4.0.3 running Python 3.11"
}

variable "application_name" {
  type = map(string)

  default = {
    staging = "staging-highly-scalable-flask-api"
    production = "production-highly-scalable-flask-api"
  }
}

variable "environment_name" {
  type = map(string)

  default = {
    staging = "staging-highly-scalable-flask-api-env"
    production = "production-highly-scalable-flask-api-env"
  }
}

variable "hosted_zone_domain_name" {
  default = "demo.kieranosborne.com.au"
  description = "This must exist in router 53 already and have NS pointing to it"
}

variable "domain_name" {
  type = map(string)

  default = {
    staging = "staging.demo.kieranosborne.com.au"
    production = "production.demo.kieranosborne.com.au"
  }
}
