# Highly Scalable Production Ready SAAS Flask API

See here for the full project broken down step by step:

https://www.youtube.com/playlist?list=PLHRoK_lnVbmLE3ErIu5UhmRkSHHKGvOVL

## Description

An in-depth paragraph about your project and overview of use.

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