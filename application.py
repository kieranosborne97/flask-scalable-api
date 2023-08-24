import os
from flask_openapi3 import OpenAPI

app = OpenAPI(__name__)


@app.route('/')
def home():
    return 'Welcome to our flask api, enjoy your stay!'


# TODO(swap to hyphen)
@app.route('/health_check')
def health_check():
    environment: str = os.environ.get('ENVIRONMENT') if os.environ.get('ENVIRONMENT') else 'localhost'
    return f'Health Check, the environment is {environment}'


if __name__ == '__main__':
    app.run(debug=True)
