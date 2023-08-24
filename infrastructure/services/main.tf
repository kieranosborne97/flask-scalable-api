
data "aws_route53_zone" "public" {
  name         = var.hosted_zone_domain_name
  private_zone = false
}

resource "aws_acm_certificate" "domain_ssl_certificate" {
  domain_name       = var.domain_name[terraform.workspace]
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}

# Create elastic beanstalk application
resource "aws_elastic_beanstalk_application" "elasticapp" {
  name = var.application_name[terraform.workspace]
}

# Create elastic beanstalk Environment
resource "aws_elastic_beanstalk_environment" "beanstalkappenv" {
  name                = var.environment_name[terraform.workspace]
  application         = aws_elastic_beanstalk_application.elasticapp.name
  solution_stack_name = var.solution_stack_name
  tier                = "WebServer"

  setting {
    namespace = "aws:ec2:vpc"
    name      = "VPCId"
    value     = var.vpc_id
  }
  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "IamInstanceProfile"
    value     = "aws-elasticbeanstalk-ec2-role"
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "AssociatePublicIpAddress"
    value     = "True"
  }

  setting {
    namespace = "aws:ec2:vpc"
    name      = "Subnets"
    value     = join(",", var.public_subnets)
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "MatcherHTTPCode"
    value     = "200"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment"
    name      = "LoadBalancerType"
    value     = "application"
  }

  setting {
    namespace = "aws:autoscaling:launchconfiguration"
    name      = "InstanceType"
    value     = "t2.medium"
  }
  setting {
    namespace = "aws:elasticbeanstalk:environment:process:default"
    name      = "HealthCheckPath"
    value     = var.health_check_url
  }
  setting {
    namespace = "aws:ec2:vpc"
    name      = "ELBScheme"
    value     = "internet facing"
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MinSize"
    value     = 1
  }
  setting {
    namespace = "aws:autoscaling:asg"
    name      = "MaxSize"
    value     = 2
  }
  setting {
    namespace = "aws:elasticbeanstalk:healthreporting:system"
    name      = "SystemType"
    value     = "enhanced"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "ListenerEnabled"
    value     = aws_acm_certificate.domain_ssl_certificate.arn == "" ? "false" : "true"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "Protocol"
    value     = "HTTPS"
  }
  setting {
    namespace = "aws:elbv2:listener:443"
    name      = "SSLCertificateArns"
    value     = aws_acm_certificate.domain_ssl_certificate.arn
  }
  setting {
    name      = "ENIVRONMENT"
    namespace = "aws:elasticbeanstalk:application:environment"
    value     = terraform.workspace
  }
}

resource "aws_route53_record" "domain_ssl_certificate_validation_records" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.domain_ssl_certificate.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.domain_ssl_certificate.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.domain_ssl_certificate.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.public.id
  ttl             = 60
}


resource "aws_acm_certificate_validation" "domain_ssl_certificate_validation" {
  certificate_arn         = aws_acm_certificate.domain_ssl_certificate.arn
  validation_record_fqdns = [aws_route53_record.domain_ssl_certificate_validation_records.fqdn]
}

resource "aws_route53_record" "domain_name_alias" {
  zone_id = data.aws_route53_zone.public.id
  name    = var.domain_name[terraform.workspace]
  type    = "A"
  alias {
    name                   = aws_elastic_beanstalk_environment.beanstalkappenv.cname
    zone_id                = var.elastic_beanstalk_zone_id
    evaluate_target_health = false
  }
}

data "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_elastic_beanstalk_environment.beanstalkappenv.load_balancers[0]
  port              = 80
}

resource "aws_lb_listener_rule" "redirect_http_to_https" {
  listener_arn = data.aws_lb_listener.http_listener.arn
  priority     = 1

  action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}