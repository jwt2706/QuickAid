import requests
import json
from pprint import pprint

# Define the URL
url = "http://localhost:8080/transcribe"

# Define the headers for the POST request
headers = {
    'Content-Type': 'application/json'
}

# Define the data for the POST request
data = {
    'transcript': 'Hello, how do i treat burns?',
    'lat': 40.7128,  # Replace with actual latitude
    'long': -74.0060  # Replace with actual longitude
}

# Send the POST request
response = requests.post(url, headers=headers, data=json.dumps(data))

# Print the response
print(f'Response status code: {response.status_code}')
response_content = response.json()
print(f'Response content: {response_content}')

# Extract the chatbot's reply
chatbot_reply = response_content.get('data')
print(f'Chatbot reply: ')
pprint(chatbot_reply.messages.content)