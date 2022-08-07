from flask import Flask, jsonify, request
import json

def configure_routes(app):
    @app.route('/', methods = ['GET'])
    def testRouteGet():
        return "test success!"
    @app.route('/testpost', methods = ['POST'])
    def testRoutePost():
        data = request.data
        if data == b'jeff':
            return "test success!", 200
        else:
            return "test failed!", 400


def testGetRoute():
    app = Flask(__name__)
    configure_routes(app);
    client = app.test_client()
    url = "/"

    response = client.get(url)
    assert response.get_data() == b'test success!'
    assert response.status_code == 200

def testPostRoutePasses():
    app = Flask(__name__)
    configure_routes(app);
    client = app.test_client()
    url = "/testpost"

    mockData = "jeff"
    response = client.post(url, data=mockData)
    assert response.status_code == 200
def testPostRouteFails():
    app = Flask(__name__)
    configure_routes(app);
    client = app.test_client()
    url = "/testpost"

    mockData = "notJeff"
    response = client.post(url, data=mockData)
    assert response.status_code == 400
