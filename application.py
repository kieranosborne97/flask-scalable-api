import os
from flask_openapi3 import OpenAPI

application = OpenAPI(__name__)


@application.route('/')
def home():
    return 'Welcome to our flask api, enjoy your stay!'


@application.route('/health-check')
def health_check():
    environment: str = os.environ.get('ENVIRONMENT') if os.environ.get('ENVIRONMENT') else 'localhost'
    return f'Health Check, the environment is {environment}'


if __name__ == '__main__':
    application.run(debug=True)
