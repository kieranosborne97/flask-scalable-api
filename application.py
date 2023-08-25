import os
from flask_openapi3 import OpenAPI, Info, Tag

info = Info(title="Highly Scalable Production Ready SAAS Flask API", version="1.0.0")
application = OpenAPI(__name__, info=info)

main_tag = Tag(name="Main", description="Some Book")


@application.get('/', tags=[main_tag])
def home():
    """
     The home route, it serves no functionality.
    """
    return 'Welcome to our flask api, enjoy your stay!'


@application.get('/health-check')
def health_check():
    """
     A simple health check that returns 200 and the current env.
    """
    environment: str = os.environ.get('ENVIRONMENT') if os.environ.get('ENVIRONMENT') else 'localhost'
    return f'Health Check, the environment is {environment}'


if __name__ == '__main__':
    application.run(debug=True)
