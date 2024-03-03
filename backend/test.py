import requests
import json

url = "http://localhost:8080/transcribe"

headers = {
    'Content-Type': 'application/json'
}

data = {
    'transcript': 'Hello, how do i treat second degree burns?',
    'lat': 40.7128,
    'long': -74.0060
}

response = requests.post(url, headers=headers, data=json.dumps(data))

print(f'Response status code: {response.status_code}')
response_content = response.json()
print(f'Response content: {response_content}')

chatbot_reply = response_content.get('data')
print(f'Chatbot reply: ')
print(chatbot_reply.messages.content)