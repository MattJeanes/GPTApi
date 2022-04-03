import falcon, json

class HelloWorldResource:
    def on_get(self, req, resp):
        resp.body = json.dumps({"result": "Hello Word!"})
        resp.status = falcon.HTTP_OK
        resp.content_type = falcon.MEDIA_JSON

app = application = falcon.App()
app.add_route("/hello_world", HelloWorldResource())