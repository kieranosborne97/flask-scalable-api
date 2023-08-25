variable "vpc_id" {
  default = "vpc-71846417"
}

variable "public_subnets" {
  default = ["subnet-f12cd6b9", "subnet-b66f14ee", "subnet-f3ab6395"]
}

variable "elastic_beanstalk_zone_id" {
  default = "Z2PCDNR3VC2G1N"
  description = "Find the correct one from your region -> https://docs.aws.amazon.com/general/latest/gr/elasticbeanstalk.html"
}

variable "health_check_url" {
  default = "/health-check"
}

variable "instance_type" {
  type = map(string)

  default = {
    staging = "t2.medium"
    production = "t2.medium"
  }
}

variable "instance_min_count" {
  type = map(string)

  default = {
    staging = 1
    production = 1
  }
}

variable "instance_max_count" {
  type = map(string)

  default = {
    staging = 2
    production = 2
  }
}

variable "solution_stack_name" {
  default = "64bit Amazon Linux 2023 v4.0.3 running Python 3.11"
  description = "https://docs.aws.amazon.com/elasticbeanstalk/latest/platforms/platform-history-python.html"
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
  description = "This hosted zone must exist in route 53 already and have name servers pointing to it"
}

variable "domain_name" {
  type = map(string)

  default = {
    staging = "staging.demo.kieranosborne.com.au"
    production = "production.demo.kieranosborne.com.au"
  }
  description = "These will be the domain names to access the api at."
}
