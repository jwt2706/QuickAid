import requests
import json

# Define the endpoint URL
url = "http://localhost:5000/predict"

# Ask for the question
question = input("Enter your question: ")

# Read the context from a text file
with open('context.txt', 'r') as file:
    context = file.read()

data = {
    "question": question,
    "context": context
}

# Send the POST request
response = requests.post(url, json=data)

# Print the response
print(json.loads(response.text))