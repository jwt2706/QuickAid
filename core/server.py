from flask import Flask, request, jsonify
from transformers import AutoModelForQuestionAnswering, AutoTokenizer, pipeline

app = Flask(__name__)

# Specify the path to your local model
model_path = "./model"
tokenizer = AutoTokenizer.from_pretrained(model_path)
model = AutoModelForQuestionAnswering.from_pretrained(model_path)

# Create a pipeline with your model and tokenizer
qa_pipeline = pipeline('question-answering', model=model, tokenizer=tokenizer)

@app.route('/predict', methods=['POST'])
def predict():
    # Get the data from the POST request.
    data = request.get_json(force=True)

    # Make prediction using the model.
    prediction = qa_pipeline(question=data['question'], context=data['context'])

    # Return the prediction.
    return jsonify(prediction)

if __name__ == '__main__':
    app.run(port=5000, debug=True)