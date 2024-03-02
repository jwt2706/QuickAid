import requests
import json

# Define the endpoint URL
url = "http://localhost:5000/predict"

# Define the question and context
data = {
    "question": "What is the capital of France?",
    "context": "France, in Western Europe, encompasses medieval cities, alpine villages and Mediterranean beaches. Paris, its capital, is famed for its fashion houses, classical art museums including the Louvre and monuments like the Eiffel Tower."
}

# Send the POST request
response = requests.post(url, json=data)

# Print the response
print(json.loads(response.text))