import falcon, os
from transformers import pipeline

current_model = None
generator = None
model_folder = os.environ["MODEL_FOLDER"]
length = int(os.environ["LENGTH"])

class GenerateResource:
  def on_post(self, req, resp):
    global current_model
    global generator
    obj = req.get_media()
    model = obj.get("model")
    text = obj.get("text")
    model_path = os.path.join(model_folder, model)
    if not os.path.isdir(model_path):
      resp.media = {"error": "model does not exist"}
      resp.status = falcon.HTTP_BAD_REQUEST
      return
    if current_model != model:
      print(f"Loading model {model}")
      generator = pipeline('text-generation', model=model_path)
      current_model = model
    output = generator(text, do_sample=True, min_length=length, max_length=length)
    output_text = output[0]['generated_text']
    print(f"Generated for prompt '{text}': {output_text}")
    resp.media = {"text": output_text}
    resp.status = falcon.HTTP_OK

app = application = falcon.App()
app.add_route("/api/generate", GenerateResource())