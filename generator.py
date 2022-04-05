import random
from transformers import set_seed, AutoTokenizer, AutoModelForCausalLM

class Generator:
  def __init__(self, model_path, length):
      self.model = AutoModelForCausalLM.from_pretrained(model_path, local_files_only=True)
      self.tokenizer = AutoTokenizer.from_pretrained(model_path, local_files_only=True)
      self.length = length

  def get_inputs(self, text):
    inputs = self.tokenizer(text, padding=False, add_special_tokens=False, return_tensors="pt")
    inputs["prompt_text"] = text
    cur_len = inputs["input_ids"].shape[-1]

    if cur_len + self.length > self.tokenizer.model_max_length:
        keep_length = self.tokenizer.model_max_length - self.length
        if keep_length <= 0:
            raise ValueError(
                "We cannot use `hole` to handle this generation the number of desired tokens exceeds the models max length"
            )

        inputs["input_ids"] = inputs["input_ids"][:, -keep_length:]
        if "attention_mask" in inputs:
            inputs["attention_mask"] = inputs["attention_mask"][:, -keep_length:]

    return inputs

  def get_text(self, text, temperature, top_p):
    if text == "" or text == None:
      text = "\n"

    set_seed(random.randrange(0, 2**32))
    inputs = self.get_inputs(text)

    gen_tokens = self.model.generate(inputs['input_ids'], do_sample=True, temperature=temperature, top_p=top_p, max_new_tokens=self.length)
    gen_tokens = gen_tokens.numpy().tolist()

    text = self.tokenizer.decode(gen_tokens[0], skip_special_tokens=True)
    prompt_length = len(self.tokenizer.decode(inputs['input_ids'][0], skip_special_tokens=True))
    output_text = text[prompt_length:]

    print(f"Generated with {temperature} temperature, {top_p} top p: [{text}]{output_text}")

    return output_text