
from flask_openapi3 import OpenAPI

app = OpenAPI(__name__)


@app.route('/')
def health_check():
    return 'Health Check'

if __name__ == '__main__':
    app.run()