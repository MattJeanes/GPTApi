import falcon, os, gc
from generator import Generator

current_model_name = None
generator = None
model_folder = os.environ["MODEL_FOLDER"]
length = int(os.environ["LENGTH"])

class GenerateResource:
  def on_post(self, req, resp):
    global current_model_name
    global generator

    obj = req.get_media()
    model_name = obj.get("model")
    text = obj.get("text")
    temperature = obj.get("temperature")
    top_p = obj.get("top_p")

    model_path = os.path.join(model_folder, model_name)
    if not os.path.isdir(model_path):
      resp.media = {"error": "model does not exist"}
      resp.status = falcon.HTTP_BAD_REQUEST
      return

    if current_model_name != model_name:
      if current_model_name != None:
        print(f"Unloading model {current_model_name}")
        del generator
        gc.collect()
      print(f"Loading model {model_name}")
      generator = Generator(model_path, length)
      current_model_name = model_name

    output_text = generator.get_text(text, temperature, top_p)
    resp.media = {"text": output_text}
    resp.status = falcon.HTTP_OK

app = application = falcon.App()
app.add_route("/api/generate", GenerateResource())
