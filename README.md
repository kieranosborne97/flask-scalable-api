# Highly Scalable Production Ready SAAS Flask API

See here for the full project broken down step by step:

https://www.youtube.com/playlist?list=PLHRoK_lnVbmLE3ErIu5UhmRkSHHKGvOVL

## Description

This project will evolve into a scalable flask api built with SaaS in-mind.
- Write the application in Python and Flask
- Set up users with Auth0
- Use Terraform to manage infrastructure as code
- Set up infrastructure on AWS like RDS, SES, S3, Elastic Beanstalk
- Take payments and manage subscriptions via Stripe 
- CI/CD with GitHub Actions

## Getting Started

Ensure you have the following setup before starting:
* Above Python 3.9
* AWS account
* Terraform installed
* GitHub account

### Infrastructure

* Plan and apply the terraform-backend
  * This will create the bucket + dynamo table to store the terraform states
* Plan and apply the services 
  * This will create the elastic beanstalk instances plus their SSL certificates, domains names etc


### Dependencies

Install all the dependencies for the flask application through:
```
pip3 install -r requirements.txt
```

### Executing program
 To start the demo server locally:
```
python3 application.py
```
To view the API documentation head to:
```
/openapi
```

### Support
Email or contact through our website:

www.klodevelopments.com.au/contact-us