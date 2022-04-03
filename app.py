import falcon, os, gc, random
from transformers import pipeline, set_seed

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
      if current_model != None:
        print(f"Unloading model {current_model}")
        del generator
        gc.collect()
      print(f"Loading model {model}")
      generator = pipeline('text-generation', model=model_path)
      current_model = model
    if text == "" or text == None:
      text = "\n"
    set_seed(random.randrange(0, 2**32))
    output = generator(text, return_full_text=False, do_sample=True, handle_long_generation="hole", max_new_tokens=length)
    output_text = output[0]['generated_text']
    print(f"Generated: [{text}]{output_text}")
    resp.media = {"text": output_text}
    resp.status = falcon.HTTP_OK

app = application = falcon.App()
app.add_route("/api/generate", GenerateResource())